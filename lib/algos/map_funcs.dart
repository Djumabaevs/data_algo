Map<String, int> groupVaccinesByType(List<Vaccine> vaccines) {
  Map<String, int> groupedVaccines = {};

  for (var vaccine in vaccines) {
    String displayName = vaccine.vaccineType.displayName ?? 'Unknown';
    if (groupedVaccines.containsKey(displayName)) {
      groupedVaccines[displayName] = groupedVaccines[displayName]! + 1;
    } else {
      groupedVaccines[displayName] = 1;
    }
  }

  return groupedVaccines;
}

Map<String, int> groupProviderNotesByType(List<ProviderNote> providerNotes) {
  Map<String, int> groupedNotes = {};

  for (var note in providerNotes) {
    String displayName = note.providerType.displayName ?? 'Unknown';
    if (groupedNotes.containsKey(displayName)) {
      groupedNotes[displayName] = groupedNotes[displayName]! + 1;
    } else {
      groupedNotes[displayName] = 1;
    }
  }

  return groupedNotes;
}

Map<String, int> groupProcedureNotesByProceduralist(
    List<ProcedureNote> procedureNotes) {
  Map<String, int> groupedNotes = {};

  for (var note in procedureNotes) {
    String proceduralist = note.proceduralist ?? 'Unknown';
    if (groupedNotes.containsKey(proceduralist)) {
      groupedNotes[proceduralist] = groupedNotes[proceduralist]! + 1;
    } else {
      groupedNotes[proceduralist] = 1;
    }
  }

  return groupedNotes;
}

Map<String, int> groupImagingResultsByType(List<ImagingResult> imagingResults) {
  Map<String, int> groupedResults = {};

  for (var result in imagingResults) {
    String displayName = result.imagingType.displayName ?? 'Unknown';

    if (groupedResults.containsKey(displayName)) {
      groupedResults[displayName] = groupedResults[displayName]! + 1;
    } else {
      groupedResults[displayName] = 1;
    }
  }

  return groupedResults;
}
