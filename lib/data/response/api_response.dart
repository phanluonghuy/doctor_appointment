import 'package:doctor_appointment/data/response/status.dart';

class ApiResponse<T> {
  // Data members
  Status? status; // Represents the API response status (loading, completed, or error)
  bool? acknowledgement; // Indicates success or failure
  String? message; // Holds the message (e.g., "Success" or error message)
  String? description; // Additional description of the response
  T? data; // Actual data returned from the API (can be of any type)

  // Constructor for initializing all members
  ApiResponse({
    this.status,
    this.acknowledgement,
    this.message,
    this.description,
    this.data,
  });

  // Named constructor for loading state
  ApiResponse.loading()
      : status = Status.loading,
        acknowledgement = null,
        message = "Loading...",
        description = null,
        data = null;

  // Named constructor for completed state with data
  ApiResponse.completed({
    this.acknowledgement,
    this.message,
    this.description,
    required this.data,
  }) : status = Status.completed;

  // Named constructor for error state with a message
  ApiResponse.error({
    this.message,
    this.description,
  })  : status = Status.error,
        acknowledgement = false,
        data = null;

  // Overriding the toString method for easy debugging and logging
  @override
  String toString() {
    return "Status: $status\nAcknowledgement: $acknowledgement\nMessage: $message\nDescription: $description\nData: $data";
  }
}
