 Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: asyncUsers.isLoading || paginatedUsers.isLoading
                  ? const SpinKitThreeBounce(
                      color: MemrTheme.pondMemr,
                      size: 30,
                    )
                  : () {
                      final uniqueUsersSet = userPermissions.toSet();

                      final ownersFromUsersPages = usersPages
                          .where((page) =>
                              page.organizationPermissions.isNotEmpty &&
                              page.organizationPermissions[0]
                                  .organizationPermissions
                                  .contains(
                                      OrganizationPermissionEnum.orgOwner))
                          .toList();
                      final userOwners = widget.user.owners;
                      debugPrint('Owners of a user: ${userOwners?.length}');
                      debugPrint(
                          'Owners list length: ${ownersFromUsersPages.length}');
                      debugPrint(
                          'Users with profile access list length: ${uniqueUsersSet.length}');

                      final combinedList = [
                        ...uniqueUsersSet,
                        ...ownersFromUsersPages
                      ];

                      final ownerList = combinedList.where((item) {
                        if (item is OrganizationProfileAuthorizedUser) {
                          final user = item;
                          final userPage = usersPages
                              .firstWhereOrNull((page) => page.id == user.id);
                          if (userPage == null) return false;

                          return userPage.organizationPermissions.isNotEmpty &&
                              userPage.organizationPermissions[0]
                                  .organizationPermissions
                                  .contains(
                                      OrganizationPermissionEnum.orgOwner);
                        } else if (item is OrganizationAuthorizedUser) {
                          return true;
                        }
                        return false;
                      }).toList();

                      final uniqueOwners = ownerList.toSetBy((user) {
                        if (user is OrganizationProfileAuthorizedUser) {
                          return '${user.firstName} ${user.lastName}';
                        } else if (user is OrganizationAuthorizedUser) {
                          return '${user.firstName} ${user.lastName}';
                        }
                        return '';
                      }).toList();
                      // debugPrint(
                      //     'Filtered by names Users with profile access list length: ${uniqueOwners.length}');

                      String getUserName(dynamic user) {
                        if (user is OrganizationProfileAuthorizedUser) {
                          return '${user.firstName} ${user.lastName}';
                        } else if (user is OrganizationAuthorizedUser) {
                          return '${user.firstName} ${user.lastName}';
                        }
                        return '';
                      }

                      final duplicatedOwners = ownerList
                          .where((user) =>
                              ownerList
                                  .where((innerUser) =>
                                      getUserName(user) ==
                                      getUserName(innerUser))
                                  .length >
                              1)
                          .toSetBy((user) => getUserName(user))
                          .toList();

                      //debugPrint('Duplicated Owners: $duplicatedOwners');
                      final uniList = uniqueOwners + uniqueUsersSet.toList();

                      return ListView.builder(
                        itemCount: uniList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = uniList[index];

                          if (item is OrganizationProfileAuthorizedUser) {
                            final user = item;
                            final userPage = usersPages
                                .firstWhereOrNull((page) => page.id == user.id);

                            if (userPage == null) {
                              return const SizedBox.shrink();
                            }

                            final permissions = user
                                    .organizationPermissions.isNotEmpty
                                ? user.organizationPermissions
                                    .expand((permission) => permission
                                        .organizationProfiles
                                        .expand((element) => element
                                            .organizationProfilePermissions))
                                    .toSet()
                                    .toList()
                                : [];
                            final bool userIsOrgOwner = userPage
                                    .organizationPermissions.isNotEmpty &&
                                userPage.organizationPermissions[0]
                                    .organizationPermissions
                                    .contains(
                                        OrganizationPermissionEnum.orgOwner);

                            final userRoles = userIsOrgOwner
                                ? 'Owner'
                                : permissions.isNotEmpty
                                    ? permissions
                                        .map((permission) =>
                                            getDisplayRole(permission))
                                        .join(', ')
                                    : 'role';

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user.firstName} ${user.lastName}',
                                      style: const TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF6A6C8C),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      userRoles,
                                      style: const TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF848484),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: const Color(0xFF84848C).withAlpha(30),
                                  thickness: 1,
                                ),
                              ],
                            );
                          } else if (item is OrganizationAuthorizedUser) {
                            const userRoles = 'Owner';

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.firstName} ${item.lastName}',
                                      style: const TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF6A6C8C),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      userRoles,
                                      style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF848484),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: const Color(0xFF84848C).withAlpha(30),
                                  thickness: 1,
                                ),
                              ],
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      );
                    }(),
            ),
          ),