Content-Type: multipart/mixed; boundary="===============3206786110787144053=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono running on new Freerunner distribution
Date: Thu, 26 Nov 2009 08:16:49 -0600
Message-ID: <200911260816.49670.denkenz@gmail.com>
In-Reply-To: <4B0FFF70.1090401@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3206786110787144053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dario,

> I recompiled from the git and the situation is the same as before;
> attached are two archives, each containing two log files, one made by
> oFono with the options above, the second is the console output of the
> "dbus-monitor --system" command (in which, at the end of file, I pasted

Please make sure you restart oFono when setting OFONO_AT_DEBUG.  The =

environment variable is checked only when the modem is created, which is =

usually startup in the case of modem.conf ones.  This will give much more =

output, including every command sent and received from the modem.

Please redo the logs with the environment variable set before ofono is =

started.

> the command lines I used to do the tests);  the first archive
> (call_answer_hangup*) is a simple test call using one of my provider
> service numbers, I simply called, they answered and I hangup the call,
> after this, as you can see, I was not able to do another call (I did my
> previous tests with my phone application and I didn't notice the error
> given by oFono, sorry!); the second archive (call_hanguptry_remotedisc*)
> is a call to another phone (I masked the number with xxxx for privacy
> purposes), tried to hangup but wasn't able to and asked the other party
> to hangup.

Ok, you were hitting a bug that Zhenhua just caught.  I pushed out his fix.=
  =

I'd be interested in first seeing whether dial -> alerting -> hangup now wo=
rks =

on a freshly booted oFono instance.

Regards,
-Denis

--===============3206786110787144053==--

