Content-Type: multipart/mixed; boundary="===============7420337551180257586=="
MIME-Version: 1.0
From: Mylene JOSSERAND <mylene.josserand@openwide.fr>
Subject: Re: Sierra using QMI with linux-3.18.5 and oFono-1.16 possible?
Date: Fri, 10 Apr 2015 11:32:48 +0200
Message-ID: <552798C0.5070707@openwide.fr>
In-Reply-To: <7D96BC0695F191498AA0147D723146AF5691319D@Ulm2-Exc1-MB1.p3-group.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7420337551180257586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dirk,


On 04/10/2015 10:04 AM, Meul, Dirk wrote:
> Hi list,
>
> I'm trying to use a Sierra MC7304 datacard in QMI mode with oFono-1.16 ru=
nning on ARM with linux-3.18.5 kernel.
>
> 1) Without modifications the MC7304 uses qmi-wwan and option drivers and =
is not recognized by oFono
> 2) After adding the product ID to the sierra module the datacard is recog=
nized and useable, but not in QMI mode
> 3) With different product ID qmi-wwan and qcserial drivers are used but s=
till not recognizes by oFono
> 4) Patched oFono-1.16 following "improving QMI support on recent kernels"=
 patch set from February 2013 by Bj=C3=B8rn Mork, no working interface, nei=
ther with patched sierra nor with qmi-wwan/qcserial
>
> As the QMI interface /dev/cdc-wdmX now is in usbmisc interface and the pa=
tch set <https://lists.ofono.org/pipermail/ofono/2013-February/014240.html>=
 wasn't merged I wonder if somebody is able to use QMI mode with recent ker=
nels.
>
> So my question: is it possible to use the QMI mode on recent kernel with =
current oFono? Are there other patches needed I didn't found?

I am currently running Ofono (1.15) on a recent kernel (3.10.17).
I am using QMI mode, on another modem than Sierra, and it works well.

I have applied the patch series of Bjorn too but, for me, one line was miss=
ing.
It is in the plugins/udevng::check_device function.
I have added the usbmisc bus to check new devices. Sorry, I do not have tim=
e to send you a patch so try to edit this line :
if (g_str_equal(bus, "usb") =3D=3D TRUE)
by this one :
if (g_str_equal(bus, "usb") =3D=3D TRUE || g_str_equal(bus, "usbmisc"))

It will allow to check usb devices on usb _and_ usbmisc buses.

As Bjorn's patches was not applied (I do not know why), I did push back thi=
s modification.
At least, I should have sent it on this list.. Sorry, I did not have time a=
nd then, I forgot it ! :(


Hope this help,

Best regards,


Myl=C3=A8ne JOSSERAND

--===============7420337551180257586==--

