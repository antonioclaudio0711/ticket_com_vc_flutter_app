import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_assets.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/check_in_button.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/event_description.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';
import 'package:ticket_com_vc_app/src/presentation/event/controller/event_controller.dart';
import 'package:ticket_com_vc_app/src/presentation/event/view/widgets/list_of_participants_button.dart';

class EventView extends StatefulWidget {
  const EventView({
    required this.event,
    super.key,
  });

  static const routeName = AppRoutes.eventAppRoute;
  final EventModel event;

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  EventModel get event => widget.event;
  final EventController _controller = EventController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: _controller.navigationService.goBack,
          icon: Icon(Icons.chevron_left),
        ),
        title: Text(
          event.name,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                event.horizontalCover,
                errorBuilder: (context, error, stacktrace) {
                  return Image.asset(
                    AppAssets.imageNotFoundAsset,
                    fit: BoxFit.cover,
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: EventDescription(
                    eventName: event.name,
                    eventDate: dateFormatter(event.startDatetime),
                    eventLocalization: event.address,
                  ),
                ),
                Center(
                  child: ListOfParticipantsButton(
                    listOfParticipantsFunction: () =>
                        _controller.navigationService.navigateTo(
                      AppRoutes.listOfParticipantsAppRoute,
                      arguments: event.id,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CheckInButton(
        containerChildWidget: Icon(
          Icons.qr_code_scanner,
          color: AppColors.purpleColor,
        ),
        checkInFunction: () => _controller.navigationService.navigateTo(
          AppRoutes.checkInAppRoute,
          arguments: event.id,
        ),
      ),
    );
  }
}
