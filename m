Content-Type: multipart/mixed; boundary="===============0730336784750785984=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: Next series of delivery report patches
Date: Fri, 04 Jun 2010 14:17:31 +0300
Message-ID: <1275650257-30593-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0730336784750785984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patches include:
1. Notify about new status report to sms-core.
2. Add new signal to DBus-interface for status report.
3. Support for basic status report (non-concatenated).
   -function structure is similar to deliver-notify,
    some functions could be combined
4. Implement setting "UseDeliveryReports" property via DBus.
5. Support for concatenated status reports.
   -add_pending_status_report() relates new MR-number to
    existing ofono_msg_id or creates a new ofono_msg_id
    and relates MR to it. Also receiver information is saved.
   -update_pending_status_report_mr_number() searches the
    msg_id to which the received MR is related and updates
    the status of the msg_id and MR accordingly. If message
    is determined as undelivered, related information is
    freed.
6. Saving pending SMS status reports to disk.
   -same basic idea as in SMS assembly storaging
   -function structure is similar to SMS assembly part.
    Status report part only has one more loop compared to it
    because of the deeper directory structure in which the
    pending status report information is saved.
   -storaging and storage freeing are called by
    add_pending_status_report() and
    update_pending_status_report_mr_number()

Next tasks:
1. Combine ofono_sms_deliver_notify() and ofono_sms_status_notify()
   as Aki Niemi requested. Still a valid task?
2. Implement received comments about these patches.

Br,
Pasi Miettinen



--===============0730336784750785984==--

