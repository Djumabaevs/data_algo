Expanded(
  child: SizedBox(
    height: MediaQuery.of(context).size.height * 0.3,
    child: asyncUsers.isLoading || paginatedUsers.isLoading
        ? const SpinKitThreeBounce(
            color: MemrTheme.pondMemr,
            size: 30,
          )
        : ListView.builder(
            itemCount: (widget.user.owners?.length ?? 0) + (widget.user.newUsers?.length ?? 0),
            itemBuilder: (BuildContext context, int index) {
              // Check if index is within the range of owners list
              if (index < (widget.user.owners?.length ?? 0)) {
                final owner = widget.user.owners?[index];
                if (owner == null) {
                  return const SizedBox.shrink();
                }

                return _buildUserRow(owner.firstName, owner.lastName, 'Owner');
              } else {
                // Adjust index for newUsers list
                final newIndex = index - (widget.user.owners?.length ?? 0);
                final newUser = widget.user.newUsers?[newIndex];
                if (newUser == null) {
                  return const SizedBox.shrink();
                }

                return _buildUserRow(newUser.firstName, newUser.lastName, 'User');
              }
            },
          ),
  ),
),

Widget _buildUserRow(String firstName, String lastName, String role) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$firstName $lastName',
            style: const TextStyle(
              fontFamily: 'Muli',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6A6C8C),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            role,
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
}
