class CancelTrip {
  int tripId, driverId, clientId;
  String startPointLat, startPointLong, endPointLat, endPointLong;
  String cost, insideOrOutSide;
  CancelTrip({
    this.tripId,
    this.driverId,
    this.clientId,
    this.startPointLat,
    this.startPointLong,
    this.endPointLat,
    this.endPointLong,
    this.cost,
    this.insideOrOutSide,
  });
}
