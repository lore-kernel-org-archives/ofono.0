Content-Type: multipart/mixed; boundary="===============7577023047258126732=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] ifx: adding Infineon modem self test
Date: Mon, 13 Dec 2010 03:29:45 +0100
Message-ID: <1292207385.30085.64.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90159DEB2FF@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7577023047258126732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > > The conclusion was that these two test commands should be issued from=
 the AP to ensure that the modem is functioning properly.
> > =

> > I am not aware of the conclusion. My understanding is still that the
> > modem firmware is suppose to do its selftests all by itself.
> =

> It does not.

this is really new to me. Last time this has been talked about, that was
different.

> > So what is the reasoning behind doing these selftests from the host.
> =

> It makes it easier for the host to record diagnostics / error codes this =
way. At the moment this is limited to recording it in the log file, as oFon=
o doesn't provide a good way for reporting back error conditions when power=
ing up a modem fails.

There is nothing more that you can provide to the host anyway. Just
having one AT command to read the selftest log from the modem would have
been just fine. Right now I am not seeing any advantage why the host
should execute selftests.

And essentially this really only makes sense once the oFono core can
mark a modem as broken and then just not even try to re-enable it.

We don't even have a state for this since it was never a requirement to
have such a state. While Lockdown comes pretty close, it is semantically
something totally different.

There is also the other thing, that we have no numbers on the expected
execution time of these selftests. This needs to be documented inside
the code. Otherwise this gets out of control.

And just to make this clear. These are run on every oFono modem enabling
execution. This is different from just on initial modem power on. Are
you okay with the impact on modem enabling time?

Regards

Marcel



--===============7577023047258126732==--

