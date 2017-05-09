Content-Type: multipart/mixed; boundary="===============6751135883668044312=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Atoms for hardware monitoring
Date: Tue, 09 May 2017 11:12:14 -0500
Message-ID: <67b55154-0c22-22dd-2d75-fc5241447f00@gmail.com>
In-Reply-To: <fdd120b37a09f9414b227ba8083ecc10@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6751135883668044312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 05/09/2017 10:45 AM, Vincent CESSON wrote:
> Hi,
>
> I am currently working with Gemalto modem Cinterion PHS8. This modem has
> hardware related commands to check voltage and temperature. For example
> read the temperature (enable temperature output and read it):
>
> AT^SCTM=3D0,1
> OK
> AT^SCTM?
> ^SCTM: 0,0,32
>
> I would like to read these parameters with Ofono but I didn't find in
> documentation any existing interface that can handle hardware
> monitoring. Maybe I could hack Ofono to add custom properties to an
> existing interface for instance, or create my own interface. But if more
> modems propose the same kind of features it could be interesting to find
> a generic API.

The rule of thumb is that if a feature is supported by most vendors, =

then we can consider adding a dedicated atom for it.  Generally these =

features have a very specific behavior and finding a unified API is =

straightforward.

For features that are more manufacturer specific we like to use plugin =

specific interfaces.

I do not recall any other manufacturers exposing such information, so =

this may be a good fit for a plugin specific interface.  There's an =

example inside ril_intel.c which adds THERMAL_MANAGEMENT_INTERFACE.

Regards,
-Denis

--===============6751135883668044312==--

