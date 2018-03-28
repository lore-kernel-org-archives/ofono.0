Content-Type: multipart/mixed; boundary="===============8237242967840471315=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 00/30] QMI rework
Date: Wed, 28 Mar 2018 20:59:46 +0200
Message-ID: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8237242967840471315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A couple of weeks ago I submitted a patch to fix an issue with QMI
modems where the LTE modem in the pre-sim state would prevent requests
from being cancelled for services created and destroyed in the online
state.  These uncancelled requests would result in callbacks into
destroyed atoms and resulting segfaults.  The comment to that patch was
that the _correct_ fix would be to rework the way QMI handles service
sharing.

So, that said, this is my attempt at cleaning up service sharing in the
QMI core.  The jist of this is that we switch to a model that looks a
bit like file descriptions/descriptors in Linux.  The QMI services
obtain a service description which manages their info and the underlying
connection (client id) state that the 'shared services' actually share.
On top of this service description we provide service descriptors which
provide private state.  Requests and notifications are registered on the
service descriptor and their lifetimes are tied to it; when the service
descriptor is closed (released), the requests and notifications can be
cleaned up without affecting other users of the shared unlying
description.

The patch series is quite long because I tried to do this systematically
in order to make the changes reviewable.  It turned out to be quite
messy and it took me a couple of attempts to actually get a sane series
together.  Everything builds and runs for every patch in the series, BUT
I am aware that there are some details that are ignored along the way
that mean that some subtle behavioural changes may be introduced.  By
the end of the series, though, these issues should mostly have been
taken care of... so please just bear this in mind when reviewing.

Perhaps controversial so I'll state it upfront:  I've introduced the
list.h header from the Linux kernel source tree into the project.  I
really hope this won't be a showstopper... the licensing matches so
there are no legal issues, in any case.  I included the entire header
even though just a few macros are actually used... if size is an issue,
we can pare the file down to about a quarter of its size.

Finally, this is still RFC as I haven't finished reviewing this
completely, myself.  But I'd be happy to get any feedback now if someone
has a chance to look at this.

Thanks,
Jonas


Jonas Bonn (30):
  qmi: remove unused fields of service_send_data
  qmi: remove headroom parameter from req_alloc
  qmi: unify common request header setup
  qmi: request_alloc has no meaningful failure path
  qmi: push request_submit into request_alloc
  qmi: rename request_alloc to request_submit
  qmi: figure out request id without accessing header
  qmi: make qmi_service_send return result
  qmi: drop 'head' pointer from request_submit
  qmi: remove unused qmi_service_cancel
  qmi: remove unused qmi_service_unregister
  qmi: replace GQueues for requests
  qmi: assume version_list is up to date
  qmi: absorb service_create_discover into service_create
  qmi: drop discovery_queue
  qmi: make services always shared
  qmi: switch service_list to list_head type
  qmi: switch notify_list to list_head type
  qmi: drop unused struct field
  qmi: reference version_info from device in services
  qmi: make version_list private
  qmi: move client_id to qmi_version
  qmi: use standard endian macros
  qmi: convert version_list to struct list head
  qmi: move service device to service_info
  qmi: make all services unique instances backed by common description
  qmi: drop qmi_service_ref function
  qmi: rename qmi_service_create/unref to open/close
  qmi: pass service directly to request_submit
  qmi: add requests to service queue

 drivers/qmimodem/devinfo.c              |    6 +-
 drivers/qmimodem/gprs-context.c         |   14 +-
 drivers/qmimodem/gprs.c                 |   12 +-
 drivers/qmimodem/list.h                 |  736 ++++++++++++++++++++
 drivers/qmimodem/location-reporting.c   |    6 +-
 drivers/qmimodem/lte.c                  |    6 +-
 drivers/qmimodem/netmon.c               |    6 +-
 drivers/qmimodem/network-registration.c |    6 +-
 drivers/qmimodem/qmi.c                  | 1120 ++++++++++++---------------=
----
 drivers/qmimodem/qmi.h                  |   27 +-
 drivers/qmimodem/radio-settings.c       |   12 +-
 drivers/qmimodem/sim-legacy.c           |    6 +-
 drivers/qmimodem/sim.c                  |   12 +-
 drivers/qmimodem/sms.c                  |    6 +-
 drivers/qmimodem/ussd.c                 |    6 +-
 drivers/qmimodem/voicecall.c            |    6 +-
 plugins/gobi.c                          |   76 +--
 17 files changed, 1270 insertions(+), 793 deletions(-)
 create mode 100644 drivers/qmimodem/list.h

-- =

2.15.1


--===============8237242967840471315==--

