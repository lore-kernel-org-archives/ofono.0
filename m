Content-Type: multipart/mixed; boundary="===============8449810028244959233=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Thu, 13 Jan 2011 09:57:58 -0600
Message-ID: <4D2F2106.5010807@gmail.com>
In-Reply-To: <1294900572.18783.21.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8449810028244959233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 01/13/2011 12:36 AM, Jukka Saunamaki wrote:
> Hello
> =

> On Wed, 2011-01-12 at 10:46 -0600, Denis Kenzior wrote:
>>> ...SIM EF-SPN... =

>>
>> You're correct that netreg is the only consumer.  There was no need for
>> anyone else to see this information.  However, this begs the question,
>> why do you need the SPN data?
> =

> Some virtual operators are using the same MCC/MNC as their host, or some
> operators have several different trade names, and these can have
> different access settings (at least different UI visible name). =

> SPN in SIM typically tells these cases apart. This is why I included
> reading SPN to that example provisioning.

Do you have specific examples?  To my knowledge the MVNOs should be
provisioning the SIM with a different MNC from the host but the network
used (and thus the network's MCC/MNC) are their host's.

> =

> All provisioning plugins might not care about SPN (e.g. the previously
> discussed one using mobile-broadband-provider-info?), so I would suggest
> not creating specific SIM API yet. Of cause it can be added later, if so
> wished.

You might be able to get away with reading of EFspn just because it is
cached nicely on disk.  But you will have to carefully consider your
plugin design if you wish to do so to avoid any race conditions and be
able to properly clean up.

Regards,
-Denis

--===============8449810028244959233==--

