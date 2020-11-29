class TripRequest {
  int tripId, driverId, clientId;
  String startPointLat, startPointLong, endPointLat, endPointLong;
  String insideOrOutSide, clientName;
  var cost;

  TripRequest({
    this.tripId,
    this.driverId,
    this.clientId,
    this.clientName,
    this.startPointLat,
    this.startPointLong,
    this.endPointLat,
    this.endPointLong,
    this.insideOrOutSide,
    this.cost,
  });
}
