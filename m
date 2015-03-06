Content-Type: multipart/mixed; boundary="===============5455822751760522289=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Using ofono for location service
Date: Fri, 06 Mar 2015 11:45:34 -0600
Message-ID: <54F9E7BE.4080409@gmail.com>
In-Reply-To: <50BCD3CCE3CFC54ABCADC6EDD7405570C5425F@BGSMSX104.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5455822751760522289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On 03/06/2015 05:55 AM, Rajashekharaiah, Kiran KumarX wrote:
> Hi,
>
> I am trying to use ofono on a linux box with TELIT HE910. How can I
> enable stand-alone gps using ofono, so that I can get GPS data without
> cellular connection?
>

The location-reporting atom is enabled in pre-sim, so in theory you =

should be able to use the modem as a GPS device without a SIM.

 From what I remember, oFono HE910 GPS support requires fairly new =

firmware and a special setting to work correctly.  See =

doc/telit-modem.txt for more information.

> Also when I tried running =E2=80=9Ctest-gnss=E2=80=9D for testing AGPS, I=
 get the
> following error(with ofonod daemon running in background):
>
> *NameError: name 'gnss' is not defined*
>

Yes, sounds like no modems with the =

org.ofono.AssistedSatelliteNavigation interface were found.

> **
>
> Does this mean AGPS is not enabled? If so how can I enable it?
>
> **

Have you powered up your telit HE 910 via enable-modem?

Regards,
-Denis

--===============5455822751760522289==--

