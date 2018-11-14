Content-Type: multipart/mixed; boundary="===============0771202061607310077=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Issue with SIM7100E pcie module
Date: Wed, 14 Nov 2018 15:53:08 +0100
Message-ID: <332b9d5f-5625-278b-d7d9-b00a0a771765@norrbonn.se>
In-Reply-To: <c678f985dd3c4056854ee615df457e38@de.bosch.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0771202061607310077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/11/2018 15:40, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> Hi,
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 For one of the IOT project, I am using SIM7100E mini =

> PCIe module. I am using connman(1.36) and ofono(1.26) to establish =

> cellular connection. I am seeing that the same module is sometimes =

> identified as gobi and sometimes as sim7100 by ofono. =C2=A0Attached the =
logs =

> for reference:
> =

> # lsusb
> =

> Bus 003 Device 008: ID 1e0e:9001 Qualcomm / Option
> =

> # /usr/lib/ofono/test/list-modems
> =

> [ /sim7100_0 ]
> =

>  =C2=A0=C2=A0=C2=A0 Type =3D hardware
> =

>  =C2=A0=C2=A0=C2=A0 Emergency =3D 0
> =

>  =C2=A0=C2=A0=C2=A0 Model =3D SIMCOM_SIM7100E
> =

>  =C2=A0=C2=A0=C2=A0 Serial =3D 866802021517042
> =

>  =C2=A0=C2=A0=C2=A0 Interfaces =3D org.ofono.SmartMessaging org.ofono.Pus=
hNotification =

> org.ofono.MessageManager org.ofono.NetworkRegistration =

> org.ofono.ConnectionManager org.ofono.Phonebook org.ofono.CallMeter =

> org.ofono.SupplementaryServices org.ofono.CallBarring =

> org.ofono.CallSettings org.ofono.CallForwarding org.ofono.MessageWaiting =

> org.ofono.AllowedAccessPoints org.ofono.VoiceCallManager =

> org.ofono.SimManager
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0SystemPath =3D =

> /sys/devices/soc0/soc/30800000.aips-bus/30b30000.usb/ci_hdrc.2/usb3/3-1/3=
-1.3
> =

>  =C2=A0=C2=A0=C2=A0 Manufacturer =3D SIMCOM INCORPORATED
> =

>  =C2=A0=C2=A0=C2=A0 Online =3D 1
> =

>  =C2=A0=C2=A0=C2=A0 Powered =3D 1
> =

>  =C2=A0=C2=A0=C2=A0 Features =3D sms net gprs ussd sim
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0Revision =3D 4534B06SIM7100E
> =

>  =C2=A0=C2=A0=C2=A0 Lockdown =3D 0
> =

> # /usr/lib/ofono/test/list-modems
> =

> [ /gobi_0 ]
> =

>  =C2=A0=C2=A0=C2=A0 Serial =3D 866802021517042
> =

>  =C2=A0=C2=A0=C2=A0 Interfaces =3D org.ofono.LongTermEvolution org.ofono.=
SmartMessaging =

> org.ofono.PushNotification org.ofono.MessageManager =

> org.ofono.NetworkRegistration org.ofono.ConnectionManager =

> org.ofono.SupplementaryServices org.ofono.NetworkMonitor =

> org.ofono.RadioSettings org.ofono.MessageWaiting =

> org.ofono.AllowedAccessPoints org.ofono.SimManager =

> org.ofono.VoiceCallManager
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0Online =3D 1
> =

>  =C2=A0=C2=A0=C2=A0 Emergency =3D 0
> =

>  =C2=A0=C2=A0=C2=A0 Features =3D sms net gprs ussd rat sim
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0Revision =3D M9615A-CETWTBZM-6.0.15255=C2=A0 1=
=C2=A0 [May 13 2016 01:00:00]
> =

>  =C2=A0=C2=A0=C2=A0 Type =3D hardware
> =

>  =C2=A0=C2=A0=C2=A0 Manufacturer =3D QUALCOMM INCORPORATED
> =

>  =C2=A0=C2=A0=C2=A0 Powered =3D 1
> =

>  =C2=A0=C2=A0=C2=A0 Model =3D SIMCOM_SIM7100E
> =

>  =C2=A0=C2=A0=C2=A0 SystemPath =3D =

> /sys/devices/soc0/soc/30800000.aips-bus/30b30000.usb/ci_hdrc.2/usb3/3-1/3=
-1.3
> =

>  =C2=A0=C2=A0=C2=A0 Lockdown =3D 0
> =

> I looked into the source code of ofono. Gobi and sim7100 both are =

> implemented as plugin. From the source code (plugins/udevng.c) it looks =

> like the module should use sim7100 plugin. But it is not always the case =

> for me.
> =

> { "gobi",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "qmi_wwan"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 },
> =

> { "gobi",               =

> "qcserial"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =

> { "sim7100",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "option",=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "1e0e", "90=
01"=C2=A0 },
> =

> Further if the module is identified as gobi, I am able to connect to the =

> internet. If it is identified as sim7100, the module gets disconnected =

> and connected again (reset) whenever I am trying to activate the context.
> =


So it seems that the device provides interfaces that attach to "option" =

and "qmi_wwan" drivers.  The ordering of these interfaces being =

announced by the kernel isn't defined, so ofono ends up picking the =

driver that matches the first interface that it recognizes... hence you =

get sometimes sim7100 and sometimes gobi.

You'll want to add something like this:

{ "sim7100",        "option",             "1e0e", "9001"  },
{ "sim7100",        "qmi_wwan",           "1e0e", "9001"  },

With that you'll be prevented from being directed to the gobi driver. =

After that you'll need to fiddle a bit with setup_sim7100 in order to =

get it to pass the qmi interfaces through to the gobi driver.  See =

setup_quectelqmi for something similar.

Hope that helps,
Jonas


> May I know what is the issue here and any idea on how to fix this issue =

> will be helpful.
> =

> Mit freundlichen Gr=C3=BC=C3=9Fen / Best regards
> =

> *Vinothkumar Eswaran
> BEG-PT/PJ-EL*
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============0771202061607310077==--

