import 'package:just_travel/models/db-models/trip_model.dart';

availablePerson(TripModel tripModel) {
  int available = tripModel.travellers!.toInt();
  if (tripModel.travellers != null && tripModel.joinedPersons != null) {
    available = tripModel.travellers!.toInt() - tripModel.joinedPersons!.toInt();
  }

  if (available >= 4){
    return 5;
  }

  return available + 1;
}
