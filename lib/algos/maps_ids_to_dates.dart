void filterItemsBasedOnDateRange() {
  if (startDateController.text.isNotEmpty &&
      endDateController.text.isNotEmpty) {
    DateTime startDate = convertToDate(startDateController.text);
    DateTime endDate =
        convertToDate(endDateController.text).add(const Duration(days: 1));

    // Set startDate to the start of the day in UTC
    startDate = DateTime.utc(startDate.year, startDate.month, startDate.day);

    // Set endDate to the end of the day in UTC
    // Since we added one day to endDate, we set the time to just before midnight of the previous day
    endDate = DateTime.utc(endDate.year, endDate.month, endDate.day)
        .subtract(const Duration(seconds: 1));

    print('Start Date: $startDate');
    print('End Date: $endDate');

    List<ClinicSummaryFileWrapper> newAvailableOptions = [];

    for (var wrapper in clinicalSummaryState.summaryOptionsToShow) {
      List<ClinicSubSummaryItem> updatedSubItems = [];

      for (var subItem in wrapper.subItems) {
        // Filter the date to ID map for each subItem
        print('subItem.dateToIdMap: ${subItem.dateToIdMap}');
        Map<DateTime, String> filteredDateToIdMap =
            subItem.dateToIdMap?.entries.where((entry) {
                  // Ensure both dates being compared are in UTC
                  DateTime entryDateUtc = entry.key.toUtc();
                  return entryDateUtc.isAfter(startDate) &&
                      entryDateUtc.isBefore(endDate);
                }).fold<Map<DateTime, String>>({}, (map, entry) {
                  map[entry.key] = entry.value;
                  return map;
                }) ??
                {};

        print('Filtered date to ids: $filteredDateToIdMap');

        // Only add subItems that have at least one date in the range
        if (filteredDateToIdMap.isNotEmpty) {
          List<DateTime> filteredDates = filteredDateToIdMap.keys.toList();
          String filteredIds = filteredDateToIdMap.values.join(", ");

          updatedSubItems.add(ClinicSubSummaryItem(
            name: subItem.name,
            title: subItem.title,
            id: filteredIds,
            metaCreatedList: filteredDates,
            metaCreated:
                filteredDates.first, // Use the first date as the metaCreated
            additionalInfo:
                '${subItem.name} (${filteredDates.length})', // Update the quantity display
            isSelected: subItem.isSelected,
            quantity: filteredDates
                .length, // Use the count of filtered dates as the quantity
          ));
        }
      }

      if (updatedSubItems.isNotEmpty) {
        newAvailableOptions.add(ClinicSummaryFileWrapper(
          type: wrapper.type,
          subItems: updatedSubItems,
        ));

        // Update the isSelected status based on the new list
        for (var subItem in updatedSubItems) {
          subItem.isSelected = true;
        }

        if (!clinicalSummaryState.optionsSelected.contains(wrapper)) {
          ref
              .read(clinicalSummaryModalNotifierProvider.notifier)
              .addOption(wrapper);
        }
      } else {
        ref
            .read(clinicalSummaryModalNotifierProvider.notifier)
            .removeOption(wrapper);
      }
    }

    ref
        .read(clinicalSummaryModalNotifierProvider.notifier)
        .addAvailableToSelectOptions(newAvailableOptions);
    bool hasResults = newAvailableOptions.isNotEmpty;

    if (hasResults) {
      ref.read(clinicalSummaryModalNotifierProvider.notifier).enableButton();
    } else {
      ref.read(clinicalSummaryModalNotifierProvider.notifier).disableButton();
    }

    ref
        .read(clinicalSummaryModalNotifierProvider.notifier)
        .setHasNoResults(!hasResults);
  }
}
