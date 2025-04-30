import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_assets.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/event_description.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.cardOnTapFunction,
  });

  final EventModel event;
  final Function() cardOnTapFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnTapFunction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
              Positioned(
                right: 0,
                bottom: 0,
                left: 0,
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: event.actuationIsActivated
                          ? AppColors.greenColor
                          : Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      event.actuationIsActivated
                          ? AppStrings.actuationActivatedString
                          : AppStrings.activateMyActuationString,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          EventDescription(
            eventName: event.name,
            eventDate: dateFormatter(event.startDatetime),
            eventLocalization: event.address,
          ),
          SizedBox(height: 8),
          Divider(),
        ],
      ),
    );
  }
}
