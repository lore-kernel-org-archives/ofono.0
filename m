Content-Type: multipart/mixed; boundary="===============0058798003649297361=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH v2 0/3] Patch Description
Date: Fri, 01 Oct 2010 01:52:23 +0800
Message-ID: <1285869146-30183-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0058798003649297361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches fix the compilation problem, as well as some memory =
leak. But the main focus is to enable Qt script so that phonesim GUI can be=
 controlled using JavaScript. In the meantime, D-Bus support is added for t=
he sake of test automation.

Here are several examples:
1. call.js (stands for incoming call and copy it to /tmp/call/)
tabRegistration.gbIncomingCall.leCaller.text =3D "12345";
tabRegistration.gbIncomingCall.pbIncomingCall.click();

Then we set the path of script and run the script with its name
dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scrip=
t.SetPath string:/tmp/call
dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scrip=
t.Run string:call.js

Now we have simulated an incoming call.

2. sms.js (stands for incoming sms and copy it to /tmp/sms/)
tabSMS.gbMessage1.leMessageSender.text =3D "Yang";
tabSMS.gbMessage1.leSMSClass.text =3D "1";
tabSMS.gbMessage1.teSMSText.setPlainText("This message is sent automaticall=
y from phonesim");
tabSMS.gbMessage1.pbSendSMSMessage.click();

Then we do the similar things as first example:
dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scrip=
t.SetPath string:/tmp/sms
dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scrip=
t.Run string:sms.js

Now we have simulated an incoming sms.

3. Get the current path for script
dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.Scrip=
t.GetPath

4. Make script return some string
The string can be any string, number, bool, date, etc in JavaScript, but it=
 couldn't be a object because of some side effect. Refer "QScriptValue Clas=
s Reference" for details.
For example, if you want to know the current incoming number, you may write=
 a script as below:
// number.js
tabRegistration.gbIncomingCall.leCaller.text

After running the script the similar way as above, you may get the number. =


By the way, you may need below file (/etc/dbus-1/system.d/phonesim.conf) so=
 that phonesim can register its service in system bus:
<!-- This configuration file specifies the required security policies
     for oFono core daemon to work. -->

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0=
//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- ../system.conf have denied everything, so we just punch some holes -=
->

  <policy user=3D"root">
    <allow own=3D"org.phonesim"/>
    <allow send_destination=3D"org.phonesim"/>
  </policy>

  <policy at_console=3D"true">
    <allow send_destination=3D"org.phonesim"/>
  </policy>

  <policy context=3D"default">
    <deny send_destination=3D"org.phonesim"/>
  </policy>

</busconfig>



Comments are welcome!

------------
Yang Gu (3):
  Move def of class ControlWidget to header file
  Some instances in ControlWidget need to be deleted
  Enable Qt Script

 Makefile.am     |    5 +-
 configure.ac    |    2 +-
 src/control.cpp |  165 ++++++++++++++++++++++++++++++++-------------------=
----
 src/control.h   |  106 +++++++++++++++++++++++++++++++++++-
 4 files changed, 203 insertions(+), 75 deletions(-)


--===============0058798003649297361==--

