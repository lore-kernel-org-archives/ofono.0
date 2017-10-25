Content-Type: multipart/mixed; boundary="===============2997063296525899366=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono 1.21 crashes with Sierra MC7455
Date: Wed, 25 Oct 2017 10:39:05 -0500
Message-ID: <8935996d-f4e9-9d6b-2d0b-6639a584c972@gmail.com>
In-Reply-To: <eb29bb3430f34595a1b99c3c22f31025@de.bosch.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2997063296525899366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/25/2017 07:38 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> Hello,
> =

> For our next connectivity project we are planning to use Connman along =

> with oFono
> =

> The version being used are Connman :1.35 and oFono:1.21
> =

> After system start up, I am seeing that the oFono process gets exited, =

> whenever I try to enable the modem by calling the python script =

> enable-modem in the test directory. However, if I restart the ofono =

> systemd service, everything works fine.
> =

> I have attached the logs for your reference. Please let me know, if any =

> further log messages are required.
> =


I see no backtrace in your logs, so there's really nothing to go on =

here.  Are you sure its oFono crashing and not systemd simply killing it =

for whatever reason?  Can you attach gdb to get the backtrace?

Regards,
-Denis

--===============2997063296525899366==--

