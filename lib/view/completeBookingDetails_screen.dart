import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../res/widgets/buttons/backButton.dart';
import '../viewModel/bookingViewDetails_viewmodel.dart';

class CompleteBookingDetailsScreen extends StatefulWidget {
  const CompleteBookingDetailsScreen({Key? key}) : super(key: key);

  @override
  _CompleteBookingDetailsScreenState createState() =>
      _CompleteBookingDetailsScreenState();
}

class _CompleteBookingDetailsScreenState
    extends State<CompleteBookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<BookingViewDetailsViewModel>()
          .getAppointmentDetails(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookingViewDetailsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Details"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CustomBackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: viewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppointmentCard(viewModel),
                  if (viewModel.medicalRecord != null)
                    _buildMedicalRecordCard(viewModel),
                  if (viewModel.testResult != null)
                    _buildTestResultCard(viewModel),
                  if (viewModel.prescription != null &&
                      viewModel.dosage != null)
                    _buildPrescriptionCard(viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildAppointmentCard(BookingViewDetailsViewModel viewModel) {
    final appointment = viewModel.appointment!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🗓 Date:",
                style: AppTextStyle.subtitle,
              ),
              Text(DateFormat("dd/MM/yyyy").format(appointment.appointmentDate),
                  style: AppTextStyle.subtitle),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("📋 Symptom:"),
              Text(appointment.symptoms),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("⏳ Status:"),
              Text(toBeginningOfSentenceCase(appointment.status),
                  style: TextStyle(
                      color: appointment.status == "completed"
                          ? Colors.green
                          : Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalRecordCard(BookingViewDetailsViewModel viewModel) {
    final medicalRecord = viewModel.medicalRecord!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("📄 Medical records", style: AppTextStyle.subtitle),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("📝 Diagnose:"),
              Text(medicalRecord.diagnosis),
            ],
          ),
          SizedBox(height: 5),
          Text("🩺 Doctor's note:"),
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(medicalRecord.notes ?? "No notes available",
                  softWrap: true)),
        ],
      ),
    );
  }

  Widget _buildTestResultCard(BookingViewDetailsViewModel viewModel) {
    final testResult = viewModel.testResult!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🧪 Test results", style: AppTextStyle.subtitle),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("🏥 Laboratory:"),
              Flexible(
                  child: Text(
                testResult.labDetails ?? "No lab details available",
                softWrap: true,
                textAlign: TextAlign.right,
              )),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("📝 Test name:"),
              Flexible(
                  child: Text(
                testResult.testName,
                softWrap: true,
                textAlign: TextAlign.right,
              )),
            ],
          ),
          const SizedBox(height: 15),
          testResult.results?.url != null
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: const Text("Test result image"),
                            ),
                            body: PhotoView(
                              imageProvider: CachedNetworkImageProvider(
                                  testResult.results?.url ?? ""),
                              enableRotation: true,
                              minScale: PhotoViewComputedScale.contained,
                            ),
                          ), // Replace with your image
                        ));
                  },
                  child: CachedNetworkImage(
                      imageUrl: testResult.results?.url ?? "",
                      height: 150,
                      fit: BoxFit.cover))
              : const Text("No test images available"),
        ],
      ),
    );
  }

  Widget _buildPrescriptionCard(BookingViewDetailsViewModel viewModel) {
    final dosage = viewModel.dosage!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("💊 Prescription", style: AppTextStyle.subtitle),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("🔹 Dosage:"),
              Text("${dosage.amountPerDose} mg"),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("⏳ Number of times/day:"),
              Text("${dosage.frequencyPerDay}"),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("📆 Time of use:"),
              Text("${dosage.duration} day(s)"),
            ],
          ),
          const SizedBox(height: 5),
          const Text("🕒 Drinking time: "),
          const SizedBox(height: 5),
          ListView(
            shrinkWrap: true,
            children: dosage.times.map((time) {
              String formattedTime =
                  time.time.toLowerCase(); // Chuyển về chữ thường để so sánh
              String emoji = "";

              switch (formattedTime) {
                case "morning":
                  emoji = "🌅";
                  break;
                case "afternoon":
                  emoji = "🌄";
                  break;
                case "evening":
                  emoji = "🌆";
                  break;
                case "night":
                  emoji = "🌙";
                  break;
              }

              return Text(
                "${toBeginningOfSentenceCase(time.time)} $emoji",
                style: AppTextStyle.caption,
                textAlign: TextAlign.right,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
