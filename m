Content-Type: multipart/mixed; boundary="===============7655778886678290602=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/3] Patch Description
Date: Wed, 13 Oct 2010 15:19:30 -0500
Message-ID: <4CB61452.7020200@gmail.com>
In-Reply-To: <1285869146-30183-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7655778886678290602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 09/30/2010 12:52 PM, Yang Gu wrote:
> This series of patches fix the compilation problem, as well as some memor=
y leak. But the main focus is to enable Qt script so that phonesim GUI can =
be controlled using JavaScript. In the meantime, D-Bus support is added for=
 the sake of test automation.
> =

> Here are several examples:
> 1. call.js (stands for incoming call and copy it to /tmp/call/)
> tabRegistration.gbIncomingCall.leCaller.text =3D "12345";
> tabRegistration.gbIncomingCall.pbIncomingCall.click();

So this is a great idea and all the patches have been pushed.  I've done
a couple of quick modifications afterward.  More info below.

> =

> Then we set the path of script and run the script with its name
> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scr=
ipt.SetPath string:/tmp/call
> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scr=
ipt.Run string:call.js
> =

> Now we have simulated an incoming call.
> =

> 2. sms.js (stands for incoming sms and copy it to /tmp/sms/)
> tabSMS.gbMessage1.leMessageSender.text =3D "Yang";
> tabSMS.gbMessage1.leSMSClass.text =3D "1";
> tabSMS.gbMessage1.teSMSText.setPlainText("This message is sent automatica=
lly from phonesim");
> tabSMS.gbMessage1.pbSendSMSMessage.click();
> =

> Then we do the similar things as first example:
> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scr=
ipt.SetPath string:/tmp/sms
> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scr=
ipt.Run string:sms.js
> =

> Now we have simulated an incoming sms.
> =

> 3. Get the current path for script
> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scr=
ipt.GetPath
> =

> 4. Make script return some string
> The string can be any string, number, bool, date, etc in JavaScript, but =
it couldn't be a object because of some side effect. Refer "QScriptValue Cl=
ass Reference" for details.
> For example, if you want to know the current incoming number, you may wri=
te a script as below:
> // number.js
> tabRegistration.gbIncomingCall.leCaller.text
> =

> After running the script the similar way as above, you may get the number=
. =


This is really valuable information.  Can you submit a patch that adds a
quick document describing this functionality? Alternatively, adding a
new section to the HACKING file might be an option as well.

> =

> By the way, you may need below file (/etc/dbus-1/system.d/phonesim.conf) =
so that phonesim can register its service in system bus:
> <!-- This configuration file specifies the required security policies
>      for oFono core daemon to work. -->
> =

> <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1=
.0//EN"
>  "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
> <busconfig>
> =

>   <!-- ../system.conf have denied everything, so we just punch some holes=
 -->
> =

>   <policy user=3D"root">
>     <allow own=3D"org.phonesim"/>
>     <allow send_destination=3D"org.phonesim"/>
>   </policy>
> =

>   <policy at_console=3D"true">
>     <allow send_destination=3D"org.phonesim"/>
>   </policy>
> =

>   <policy context=3D"default">
>     <deny send_destination=3D"org.phonesim"/>
>   </policy>
> =

> </busconfig>
> =

> =


One of the changes I made was to have phonesim register to the system
bus.  This makes the above DBus configuration file unnecessary.  Running
phonesim on the system bus was too much of a security risk, and wasn't
really needed.

Regards,
-Denis

--===============7655778886678290602==--

