Content-Type: multipart/mixed; boundary="===============4727349508216185345=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Problem with $(NM)
Date: Fri, 28 Aug 2009 14:29:54 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001AB65F2DB@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <1251438072.2950.124.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4727349508216185345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of Marcel Holtmann
>Sent: Friday, August 28, 2009 1:41 PM
>To: ofono(a)ofono.org
>Subject: Re: Problem with $(NM)
>
>Hi Yang,
>
>> If you used the latest code, and met the problem that $(NM) couldn't be
>substituted correctly, here is the phenomenon, reason and solution.
>>
>> Phenomenon: There is a build error till almost the end of whole build, a=
nd the
>error message looks like:
>> gdbus/mainloop.o gdbus/object.o gdbus/watch.o gisi/netlink.o gisi/socket=
.o
>gisi/client.o gisi/pep.o gisi/pipe.o drivers/isimodem/isimodem.o
>drivers/isimodem/phonebook.o drivers/isimodem/devinfo.o
>drivers/isimodem/network-registration.o drivers/isimodem/voicecall.o
>drivers/isimodem/sms.o drivers/isimodem/sim.o drivers/isimodem/ssn.o
>drivers/isimodem/ussd.o drivers/isimodem/call-forwarding.o
>drivers/isimodem/call-settings.o drivers/isimodem/call-barring.o
>drivers/isimodem/call-meter.o gatchat/gatchat.o gatchat/gatresult.o
>gatchat/gatsyntax.o gatchat/ringbuffer.o drivers/atmodem/atmodem.o
>drivers/atmodem/call-settings.o drivers/atmodem/sms.o
>drivers/atmodem/call-forwarding.o drivers/atmodem/call-meter.o
>drivers/atmodem/network-registration.o drivers/atmodem/sim.o
>drivers/atmodem/ussd.o drivers/atmodem/voicecall.o
>drivers/atmodem/call-barring.o drivers/atmodem/phonebook.o
>drivers/atmodem/ssn.o drivers/atmodem/devinfo.o plugins/generic_at.o
>plugins/example_history.o src/main.o s
> rc
>>  /log.o src/plugin.o src/modem.o src/common.o src/manager.o src/dbus.o
>src/util.o src/network.o src/voicecall.o src/ussd.o src/sms.o src/call-set=
tings.o
>src/call-forwarding.o src/call-meter.o src/smsutil.o src/ssn.o src/call-ba=
rring.o
>src/sim.o src/phonebook.o src/history.o src/message-waiting.o src/simutil.=
o |
>gawk '{ print $3 }' | sort -u | \
>>                                 /bin/grep -E -e '^ofono_' -e '^g_dbus_' >
>src/ofono.exp
>> /bin/sh: gdbus/mainloop.o: Permission denied
>>
>> Reason:
>> In latest Makefile.am, $(NM) is used as below:
>> src/ofono.exp: $(src_ofonod_OBJECTS)
>> 	$(AM_V_GEN)$(NM) $^ | $(AWK) '{ print $$3 }' | sort -u | \
>> 				$(EGREP) -e '^ofono_' -e '^g_dbus_' > $@
>>
>> The error shows that $(NM) wasn't substituted with correct value. $(NM)
>should be substituted by libtool, and my libtool is somewhat buggy to subs=
titute
>it correctly. By the way, I'm using Fedora 10, and the libtool in it is ve=
rsion
>1.5.26.
>>
>> Solution (either one is OK):
>> 1. Add "AC_SUBST(NM) " in configure.ac
>> 2. Change your libtool. In file /usr/share/aclocal/libtool.m4, in section
>AC_PROG_NM, Add one line as below:
>> NM=3D"$lt_cv_path_NM"
>> AC_SUBST([NM])  #This line is added
>> ])# AC_PROG_NM
>
>what happens if you remove the AC_PROG_NM line completely. Does
>AC_PROG_LIBTOOL get you the right substitution?

No. The same error if AC_PROG_NM is removed. =


>I am not fixing a stupid broken libtool since this issue doesn't exists
>in the release tarball and Fedora 11 is just fine. File a bug against
>Fedora 10 so they fix it in their distro.

I also think this should not be fixed in oFono. However, it's a bug of libt=
ool and later version of it has fixed this. So Fedora 11 is OK with the bui=
ld.


>Regards
>
>Marcel
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono


Regards,
-Yang

--===============4727349508216185345==--

