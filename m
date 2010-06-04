Content-Type: multipart/mixed; boundary="===============5685595389432416754=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: Next series of delivery report patches
Date: Fri, 04 Jun 2010 14:28:05 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A4C@jklmail01.ixonos.local>
In-Reply-To: <1275650257-30593-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5685595389432416754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Patches include:
> 1. Notify about new status report to sms-core.
> 2. Add new signal to DBus-interface for status report.
> 3. Support for basic status report (non-concatenated).
>    -function structure is similar to deliver-notify,
>     some functions could be combined
> 4. Implement setting "UseDeliveryReports" property via DBus.
> 5. Support for concatenated status reports.
>    -add_pending_status_report() relates new MR-number to
>     existing ofono_msg_id or creates a new ofono_msg_id
>     and relates MR to it. Also receiver information is saved.
>    -update_pending_status_report_mr_number() searches the
>     msg_id to which the received MR is related and updates
>     the status of the msg_id and MR accordingly. If message
>     is determined as undelivered, related information is
>     freed.
> 6. Saving pending SMS status reports to disk.
>    -same basic idea as in SMS assembly storaging
>    -function structure is similar to SMS assembly part.
>     Status report part only has one more loop compared to it
>     because of the deeper directory structure in which the
>     pending status report information is saved.
>    -storaging and storage freeing are called by
>     add_pending_status_report() and
>     update_pending_status_report_mr_number()
>
> Next tasks:
> 1. Combine ofono_sms_deliver_notify() and ofono_sms_status_notify()
>    as Aki Niemi requested. Still a valid task?
> 2. Implement received comments about these patches.
>
> Br,
> Pasi Miettinen

Hmm, my starting paragraph disappeared to somewhere while sending,
but here it is:

I have been implementing your comments considering my previous
patches and hopefully these are a step in the right direction.
I checked the patches with checkpatch.pl and only error I get
is "ERROR: Missing Signed-off-by". Patches 5 and 6 have a little bit
more stuff on them. I tried to include comments to critical
code points, but if something is unclear, please ask and I
try to clarify my intentions.

Br,
Pasi




--===============5685595389432416754==--

