Content-Type: multipart/mixed; boundary="===============7029458809109551458=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: Problem with $(NM)
Date: Fri, 28 Aug 2009 10:10:09 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001AB65F186@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7029458809109551458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all, =

If you used the latest code, and met the problem that $(NM) couldn't be sub=
stituted correctly, here is the phenomenon, reason and solution.

Phenomenon: There is a build error till almost the end of whole build, and =
the error message looks like:
gdbus/mainloop.o gdbus/object.o gdbus/watch.o gisi/netlink.o gisi/socket.o =
gisi/client.o gisi/pep.o gisi/pipe.o drivers/isimodem/isimodem.o drivers/is=
imodem/phonebook.o drivers/isimodem/devinfo.o drivers/isimodem/network-regi=
stration.o drivers/isimodem/voicecall.o drivers/isimodem/sms.o drivers/isim=
odem/sim.o drivers/isimodem/ssn.o drivers/isimodem/ussd.o drivers/isimodem/=
call-forwarding.o drivers/isimodem/call-settings.o drivers/isimodem/call-ba=
rring.o drivers/isimodem/call-meter.o gatchat/gatchat.o gatchat/gatresult.o=
 gatchat/gatsyntax.o gatchat/ringbuffer.o drivers/atmodem/atmodem.o drivers=
/atmodem/call-settings.o drivers/atmodem/sms.o drivers/atmodem/call-forward=
ing.o drivers/atmodem/call-meter.o drivers/atmodem/network-registration.o d=
rivers/atmodem/sim.o drivers/atmodem/ussd.o drivers/atmodem/voicecall.o dri=
vers/atmodem/call-barring.o drivers/atmodem/phonebook.o drivers/atmodem/ssn=
.o drivers/atmodem/devinfo.o plugins/generic_at.o plugins/example_history.o=
 src/main.o src/log.o src/plugin.o src/modem.o src/common.o src/manager.o s=
rc/dbus.o src/util.o src/network.o src/voicecall.o src/ussd.o src/sms.o src=
/call-settings.o src/call-forwarding.o src/call-meter.o src/smsutil.o src/s=
sn.o src/call-barring.o src/sim.o src/phonebook.o src/history.o src/message=
-waiting.o src/simutil.o | gawk '{ print $3 }' | sort -u | \
                                /bin/grep -E -e '^ofono_' -e '^g_dbus_' > s=
rc/ofono.exp
/bin/sh: gdbus/mainloop.o: Permission denied

Reason:
In latest Makefile.am, $(NM) is used as below:
src/ofono.exp: $(src_ofonod_OBJECTS)
	$(AM_V_GEN)$(NM) $^ | $(AWK) '{ print $$3 }' | sort -u | \
				$(EGREP) -e '^ofono_' -e '^g_dbus_' > $@

The error shows that $(NM) wasn't substituted with correct value. $(NM) sho=
uld be substituted by libtool, and my libtool is somewhat buggy to substitu=
te it correctly. By the way, I'm using Fedora 10, and the libtool in it is =
version 1.5.26. =


Solution (either one is OK):
1. Add "AC_SUBST(NM) " in configure.ac
2. Change your libtool. In file /usr/share/aclocal/libtool.m4, in section A=
C_PROG_NM, Add one line as below:
NM=3D"$lt_cv_path_NM"
AC_SUBST([NM])  #This line is added
])# AC_PROG_NM


Regards,
-Yang



--===============7029458809109551458==--

