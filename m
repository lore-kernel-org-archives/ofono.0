Content-Type: multipart/mixed; boundary="===============4369876516180640210=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Network information can't be updated dynamically
Date: Wed, 29 Jul 2009 21:01:15 -0500
Message-ID: <200907292101.15429.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1302053C5009@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4369876516180640210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi,
>
> >The only thing that oFono core will poll periodically is the network
> >operators.  Everything else must be handled by the driver.  For network
> > status updates atmodem sends an AT+CREG=3D2, quoting 27.007:
> >
> >"2 - enable network registration and location information unsolicited
> > result code +CREG: <stat>[,<lac>,<ci>[,<AcT>]]"
>
> How ofono known the changed network status?  Registed -> roaming

The modem tells it?

>
> Suppose UI want to show the status, which interface can be used?

You use the NetworkRegistration interface, 'Status' property.

Regards,
-Denis

--===============4369876516180640210==--

