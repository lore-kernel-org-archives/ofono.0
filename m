Content-Type: multipart/mixed; boundary="===============6921703246155052151=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: What should happen after losing and retrieving gsm signal ?
Date: Tue, 07 Dec 2010 18:00:49 +0100
Message-ID: <20101207170412.263820@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6921703246155052151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to re-establish a 3G connection after a gsm signal loss and
I'm getting some pretty strange results.

So first, some short and general questions : What should happen after
going off gsm coverage and back again ?
In particular, is ofono taking care of the network registration or
does it need a manual call org.ofono.NetworkRegistration.Register ?
Also, is ofono reactivating a previously activated context or does it
needs a manual call ?

I'm running my tests on the following platform :
 =C2=A0 =C2=A0- Atom Z520 based.
 =C2=A0 =C2=A0- 2 ethernet
 =C2=A0 =C2=A0- 2 gsm modem: Option GTM382, usb ID 0af0:7601, firmware 2.9.=
4.0Hd
 =C2=A0 =C2=A0- 1 wlan ath9k (unused for the tests)

Software side:
 =C2=A0 =C2=A0- linux 2.6.35.9
 =C2=A0 =C2=A0- connman 0.64
 =C2=A0 =C2=A0- ofono 0.36
 =C2=A0 =C2=A0- dbus 1.2.20

I'm using only one modem and I have a variable antenna attenuator to
simulate gsm signal loss/retrieval. The device is not moving and the
signal strength is around 60% without attenuation. The sim card used
is configured with a dedicated password authenticated APN connected
to our internal network through vpn. The context is created before
the first test. Then the sequence of my test is as follow:
 =C2=A0 =C2=A0- power-up device
 =C2=A0 =C2=A0- call activate_context (no antenna attenuation)
 =C2=A0 =C2=A0- Set attenuator to the max (-60dB)
 =C2=A0 =C2=A0- Set attenuator back to 0
 =C2=A0 =C2=A0- call activate_context again

I'm getting some mixed results:
 * connman crash (sig11) when stopping attenuation
 or reactivating context:
 =C2=A0 =C2=A0This is obviously a connman bug (will post backtrace to connm=
an
 =C2=A0 =C2=A0ml), but after connman is restarted, the modem service does n=
ot
 =C2=A0 =C2=A0appear and I have to restart both connman and ofono. Is there=
 a
 =C2=A0 =C2=A0startup dependency between connman and ofono ?

 * Network Registration stays in registered state with
 strength =3D 0 :
 =C2=A0 =C2=A0This happens with attenuation set to -60dB. I haven't been ab=
le
 =C2=A0 =C2=A0to catch some debug traces with AT_DEBUG on. I've waited one =
hour
 =C2=A0 =C2=A0and nothing else happened.

 * Network Registration stays in searching state with
 strength !=3D 0 :
 =C2=A0 =C2=A0This happens after setting attenuator back to 0dB. I also don=
't
 =C2=A0 =C2=A0have debug traces for this case. After waiting 15 minutes, I
 =C2=A0 =C2=A0called the method org.ofono.NetworkRegistration.Register and
 =C2=A0 =C2=A0things went back to normal.

 * Calling activate_context exits with timeout :
 =C2=A0 =C2=A0This is the most common case, debug trace below shows that the
 =C2=A0 =C2=A0modem never sends the _OWANCALL callback. After waiting more =
than
 =C2=A0 =C2=A0an hour, I restarted ofono and called activate_context, it wo=
rked.

(actual apn, username and password have been replaced)
2010-12-06_16:44:15.28570 user.notice: test: reactivate context
2010-12-06_16:44:15.36944 daemon.info: ofonod[1109]: Control: > AT$QCPDPP=
=3D1,1,"password","username"\r
2010-12-06_16:44:15.44620 daemon.info: ofonod[1109]: Control: < \r\nOK\r\n
2010-12-06_16:44:15.44636 daemon.info: ofonod[1109]: Control: > AT+CGDCONT=
=3D1,"IP","apn"\r
2010-12-06_16:44:15.45019 daemon.info: ofonod[1109]: App: < \r\n_OSIGQ: 14,=
0\r\n
2010-12-06_16:44:15.47923 daemon.info: ofonod[1109]: Control: < \r\nOK\r\n
2010-12-06_16:44:15.47938 daemon.info: ofonod[1109]: Control: > AT_OWANCALL=
=3D1,1,1\r
2010-12-06_16:44:15.48118 daemon.info: ofonod[1109]: Control: < \r\nOK\r\n
2010-12-06_16:44:24.42033 daemon.info: ofonod[1109]: App: < \r\n_OSIGQ: 16,=
0\r\n
2010-12-06_16:44:27.42032 daemon.info: ofonod[1109]: App: < \r\n_OSIGQ: 17,=
0\r\n
2010-12-06_16:44:33.42032 daemon.info: ofonod[1109]: App: < \r\n_OSIGQ: 16,=
0\r\n
2010-12-06_16:44:42.41933 daemon.info: ofonod[1109]: App: < \r\n_OSIGQ: 17,=
0\r\n
...

I can run some other tests and provide full logs if needed, Do you
think there is something wrong with the test I'm running ?
Might the modem be@fault ?

--
Thanks for reading so far,
Beno=C3=AEt.

--===============6921703246155052151==--

