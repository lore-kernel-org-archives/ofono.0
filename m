Content-Type: multipart/mixed; boundary="===============3558291898006649796=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Regarding multiple APN support in ofono/connman
Date: Wed, 11 Jan 2017 17:26:16 -0600
Message-ID: <733ce497-2a7f-d345-0263-e7f33187dfd8@gmail.com>
In-Reply-To: <CAN3FBZa__Ki3eCsedpFr9zQucKmVUs=pB3jPeNJPMmmnV==EbQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3558291898006649796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naveen,

On 01/11/2017 01:39 PM, Naveen Kumar Danturi wrote:
> Hi Ofono team,
> Is there a support in ofono for multiple PDN connections in parallel ?
> If so what interfaces/API's it exposes to connman to manage multiple
> APN's ? If so, I have these 2 questions :

Yes, oFono can activate multiple active contexts, assuming the hardware =

& driver supports this.  See doc/connman-api.txt.  This is the same =

interface ConnMan is using currently.  However, ConnMan only manages a =

single context of type=3D"internet".  I think there were some patches for =

ConnMan to support multiple active internet contexts, but I'm not sure =

if they ever were accepted upstream.

>
> a)  How ofono/connman able to construct / destruct routing tables on
> data connections for multiple APNs and makes sure that IP traffic goes
> to the right IP interface/APN ?

All routing table management is outside of oFono's area of =

responsibility.  Typically an application would use direct interface =

binding to use contexts that are not managed by ConnMan.

>
> b)How ofono/connman ensures that domain name searches are performed via
> right IP interface/APN to the right name server. Provide mechanism to
> keep track of name servers associated with each APN ? I believe Linux
> only provides a mechanism for a single APN via /etc/resolv.con

Again, this is outside of oFono's area of responsibility.  We only =

provide the DNS information for each context.

>
> c) Is it configurable from upper layers to ensure that if IPV6 is
> available then IPV6 routing and name discovery is used ?

Not oFono's responsibility either.

Regards,
-Denis

--===============3558291898006649796==--

