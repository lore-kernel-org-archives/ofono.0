Content-Type: multipart/mixed; boundary="===============4635187278358916655=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Network information can't be updated dynamically
Date: Thu, 30 Jul 2009 09:51:09 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C5009@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200907291224.24273.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4635187278358916655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>The only thing that oFono core will poll periodically is the network
>operators.  Everything else must be handled by the driver.  For network st=
atus
>updates atmodem sends an AT+CREG=3D2, quoting 27.007:
>
>"2 - enable network registration and location information unsolicited resu=
lt
>code +CREG: <stat>[,<lac>,<ci>[,<AcT>]]"

How ofono known the changed network status?  Registed -> roaming =


Suppose UI want to show the status, which interface can be used?

>>For signal strength oFono explicitly doesn't poll this in the reference
>driver.  This is because vast majority of vendors out there have their own
>specific command to turn on period signal strength updates.  If you want t=
his
>feature, you need to submit a patch that enables this support explicitly.
>
Ok, we handle it as special command of modem.

>Regards,
>-Denis

Thanks =

Zhigang

>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============4635187278358916655==--

