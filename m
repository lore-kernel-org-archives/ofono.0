Content-Type: multipart/mixed; boundary="===============8669175372574132578=="
MIME-Version: 1.0
From: Kallumari Nagaraja Rao, RammohanX <rammohanx.kallumari.nagaraja.rao@intel.com>
Subject: RE: telit he910 activate-context issue
Date: Mon, 09 Mar 2015 09:05:19 +0000
Message-ID: <222E70FA67D72A4FB8EEDF5AF01724ACC99A52@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <54F9F1E3.8070001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8669175372574132578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

Sorry if I am doing something wrong in posting my queries.

Not sure on top-posting stuff.

Regards,
<Ram>


-----Original Message-----
From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Denis Kenzior
Sent: Friday, March 06, 2015 11:59 PM
To: ofono(a)ofono.org
Subject: Re: telit he910 activate-context issue

Hi Ram,

Please do not top-post on this mailing list.

On 03/06/2015 02:28 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Denis,
>
> PFA the logs with AT&C0 & without. With &C0 it is not even creating a con=
text.
>

I have just tried my HE910 with unmodified oFono 1.16 and I am able to succ=
essfully activate the context.

My firmware version is 12.00.003, but 12.00.004 is recommended.

What you should be seeing is something like this:

ofonod[19130]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
cid 1
ofonod[19130]: Modem: > AT+CGDCONT=3D1,"IP",""\r
ofonod[19130]: Modem: < AT+CGDCONT=3D1,"IP",""\r
ofonod[19130]: Modem: < \r\nOK\r\n
ofonod[19130]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[19130]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[19130]: Modem: < AT+CGDATA=3D"PPP",1\r
ofonod[19130]: Modem: < \r\nCONNECT\r\n
ofonod[19130]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
ofonod[19130]: drivers/atmodem/gprs-context.c:setup_ppp()
ofonod[19130]: drivers/atmodem/gprs-context.c:ppp_connect()

What you are seeing is this:

ofonod[6586]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
cid 1
ofonod[6586]: Aux: < \r\n
ofonod[6586]: Aux: < +CIEV: rssi,5\r\n
ofonod[6586]: src/network.c:ofono_netreg_strength_notify() strength 100
ofonod[6586]: Aux: < \r\n
ofonod[6586]: Aux: < +CIEV: rssi,4\r\n
ofonod[6586]: src/network.c:ofono_netreg_strength_notify() strength 80
ofonod[6586]: Terminating

That tells me that the port detected as the 'Modem' port is incorrect.

ofonod[6586]: plugins/udevng.c:setup_he910() modem=3D/dev/ttyACM0
aux=3D/dev/ttyACM3 gps=3D/dev/ttyACM5

Please check that those TTYs are indeed live and can accept AT commands. =

  If not, then you need to update firmware, set the appropriate PORTSEL set=
ting or update plugins/udevng.c logic for detecting your particular variant=
 of HE910.

Regards,
-Denis
_______________________________________________
ofono mailing list
ofono@ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============8669175372574132578==--

