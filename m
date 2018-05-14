Content-Type: multipart/mixed; boundary="===============3057996140760299986=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Mon, 14 May 2018 08:45:45 +0200
Message-ID: <20180514064545.GA25301@amd>
In-Reply-To: <20180512161842.7a68dc38@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3057996140760299986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> nice to hear, somebody else is using it.
> =

> The voicecall driver needs to be refactored as Denis already pointed
> out on the mailinglist before it can go upstream.
> =

> The original idea of the voice_generated.c/h files was to create a
> prototype how qmi generated files should look like and then write a
> code generator for it, as the other qmi related projects already do.
> =

> I'ven't yet took a closer look on your patches together with modems and
> a gsm network. Hopefully I can do it next week together with the
> required refactoring for upstream.

I got it to build, but quick test did not result in working call. I'm
using AT commands simultaneously on another channel.

Ideas welcome.

Best regards,
								Pavel

ce64aadfc798225807c25
Author: Alexander Couzens <lynxis@fe80.eu>
Date:   Tue Oct 17 10:11:19 2017 +0200

    call-list: fix a race condition in ofono_call_list_dial_callback

    If ofono_call_list_dial_callback is called later than
        ofono_call_list_notify, the new call is added, removed, added
	    again.

ofonod[6708]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[6708]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 2
ofonod[6708]: src/gprs.c:registration_status_cb() /gobi_0 error 0
status 1
ofonod[6708]: src/gprs.c:ofono_gprs_status_notify() /gobi_0 status
registered (1)
ofonod[6708]: src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[6708]: drivers/qmimodem/network-registration.c:get_rssi_cb()
ofonod[6708]: drivers/qmimodem/network-registration.c:get_rssi_cb()
signal with -56 dBm on 5
ofonod[6708]: drivers/qmimodem/network-registration.c:get_rssi_cb()
ofonod[6708]: drivers/qmimodem/network-registration.c:get_rssi_cb()
signal with -56 dBm on 5
ofonod[6708]: drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[6708]: drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[6708]: drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[6708]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[6708]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 2
ofonod[6708]: src/gprs.c:ofono_gprs_status_notify() /gobi_0 status
registered (1)
ofonod[6708]: drivers/qmimodem/network-registration.c:ss_info_notify()
ofonod[6708]:
drivers/qmimodem/network-registration.c:extract_ss_info()
ofonod[6708]:
drivers/qmimodem/network-registration.c:extract_ss_info() serving
system status 1
ofonod[6708]:
drivers/qmimodem/network-registration.c:extract_ss_info() radio in use
5
ofonod[6708]:
drivers/qmimodem/network-registration.c:extract_ss_info() radio in use
2
ofonod[6708]:
drivers/qmimodem/network-registration.c:extract_ss_info() lac -1
cellid -1 tech -1
ofonod[6708]: src/network.c:ofono_netreg_status_notify() /gobi_0
status 1 tech -1 lac -1 ci -1
ofonod[6708]:
drivers/qmimodem/network-registration.c:qmi_current_operator()
ofonod[6708]: src/network.c:current_operator_callback() 0x5a0c98,
0x5a1f20
ofonod[6708]:
drivers/qmimodem/network-registration.c:qmi_signal_strength()
ofonod[6708]: src/gprs.c:netreg_status_changed() 1
ofonod[6708]: src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[6708]: drivers/qmimodem/network-registration.c:get_rssi_cb()
ofonod[6708]: drivers/qmimodem/network-registration.c:get_rssi_cb()
signal with -56 dBm on 5
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
signal with 80%(-55 dBm) on 5
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
signal with 80%(-56 dBm) on 5
ofonod[6708]: drivers/qmimodem/voicecall.c:dial_cb() QMI Error 3
ofonod[6708]: src/voicecall.c:dial_handle_result() Dial callback
returned error: Unknown error type
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
signal with 80%(-55 dBm) on 5
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
signal with 80%(-56 dBm) on 5
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[6708]: drivers/qmimodem/network-registration.c:event_notify()
signal with 80%(-55 dBm) on 5



-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============3057996140760299986==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscjVNSmtBQ2drUU1PZndhcFhiK3ZJZDZ3Q2VKSnVMUG9mMnBXUmpBeDRQR0lQQ1ZRRGcK
ejhvQW5SWTFZbWZzMC9EcW1ZTDFHMlM5Q2ZRTmNQMmIKPXZSMUsKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============3057996140760299986==--

