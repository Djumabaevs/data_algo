ElevatedButton(
                onPressed: buttonDisabled
                    ? null
                    : () {
                        List<ClinicSummaryFileWrapper> selectedItems = [];

                        for (var item
                            in clinicalSummaryState.availableOptionsToSelect) {
                          var selectedSubItems = item.subItems
                              .where((subItem) => subItem.isSelected)
                              .toList();

                          if (selectedSubItems.isNotEmpty) {
                            List<ClinicSubSummaryItem> individualSubItems = [];

                            for (var subItem in selectedSubItems) {
                              List<String> ids = subItem.id.split(", ");

                              for (var id in ids) {
                                individualSubItems.add(ClinicSubSummaryItem(
                                  name: subItem.name,
                                  title: subItem.title,
                                  id: id,
                                  metaCreated: subItem.metaCreated,
                                  additionalInfo: subItem.additionalInfo,
                                  isSelected: subItem.isSelected,
                                ));
                              }
                            }

                            selectedItems.add(ClinicSummaryFileWrapper(
                              type: item.type,
                              subItems: individualSubItems,
                            ));
                          }
                        }

                        onGenerateSummary(selectedItems);
                      },