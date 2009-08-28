Content-Type: multipart/mixed; boundary="===============3187991159197380828=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem with $(NM)
Date: Thu, 27 Aug 2009 22:41:12 -0700
Message-ID: <1251438072.2950.124.camel@localhost.localdomain>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001AB65F186@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3187991159197380828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> If you used the latest code, and met the problem that $(NM) couldn't be s=
ubstituted correctly, here is the phenomenon, reason and solution.
> =

> Phenomenon: There is a build error till almost the end of whole build, an=
d the error message looks like:
> gdbus/mainloop.o gdbus/object.o gdbus/watch.o gisi/netlink.o gisi/socket.=
o gisi/client.o gisi/pep.o gisi/pipe.o drivers/isimodem/isimodem.o drivers/=
isimodem/phonebook.o drivers/isimodem/devinfo.o drivers/isimodem/network-re=
gistration.o drivers/isimodem/voicecall.o drivers/isimodem/sms.o drivers/is=
imodem/sim.o drivers/isimodem/ssn.o drivers/isimodem/ussd.o drivers/isimode=
m/call-forwarding.o drivers/isimodem/call-settings.o drivers/isimodem/call-=
barring.o drivers/isimodem/call-meter.o gatchat/gatchat.o gatchat/gatresult=
.o gatchat/gatsyntax.o gatchat/ringbuffer.o drivers/atmodem/atmodem.o drive=
rs/atmodem/call-settings.o drivers/atmodem/sms.o drivers/atmodem/call-forwa=
rding.o drivers/atmodem/call-meter.o drivers/atmodem/network-registration.o=
 drivers/atmodem/sim.o drivers/atmodem/ussd.o drivers/atmodem/voicecall.o d=
rivers/atmodem/call-barring.o drivers/atmodem/phonebook.o drivers/atmodem/s=
sn.o drivers/atmodem/devinfo.o plugins/generic_at.o plugins/example_history=
.o src/main.o src
>  /log.o src/plugin.o src/modem.o src/common.o src/manager.o src/dbus.o sr=
c/util.o src/network.o src/voicecall.o src/ussd.o src/sms.o src/call-settin=
gs.o src/call-forwarding.o src/call-meter.o src/smsutil.o src/ssn.o src/cal=
l-barring.o src/sim.o src/phonebook.o src/history.o src/message-waiting.o s=
rc/simutil.o | gawk '{ print $3 }' | sort -u | \
>                                 /bin/grep -E -e '^ofono_' -e '^g_dbus_' >=
 src/ofono.exp
> /bin/sh: gdbus/mainloop.o: Permission denied
> =

> Reason:
> In latest Makefile.am, $(NM) is used as below:
> src/ofono.exp: $(src_ofonod_OBJECTS)
> 	$(AM_V_GEN)$(NM) $^ | $(AWK) '{ print $$3 }' | sort -u | \
> 				$(EGREP) -e '^ofono_' -e '^g_dbus_' > $@
> =

> The error shows that $(NM) wasn't substituted with correct value. $(NM) s=
hould be substituted by libtool, and my libtool is somewhat buggy to substi=
tute it correctly. By the way, I'm using Fedora 10, and the libtool in it i=
s version 1.5.26. =

> =

> Solution (either one is OK):
> 1. Add "AC_SUBST(NM) " in configure.ac
> 2. Change your libtool. In file /usr/share/aclocal/libtool.m4, in section=
 AC_PROG_NM, Add one line as below:
> NM=3D"$lt_cv_path_NM"
> AC_SUBST([NM])  #This line is added
> ])# AC_PROG_NM

what happens if you remove the AC_PROG_NM line completely. Does
AC_PROG_LIBTOOL get you the right substitution?

I am not fixing a stupid broken libtool since this issue doesn't exists
in the release tarball and Fedora 11 is just fine. File a bug against
Fedora 10 so they fix it in their distro.

Regards

Marcel



--===============3187991159197380828==--

