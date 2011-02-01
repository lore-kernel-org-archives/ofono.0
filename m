Content-Type: multipart/mixed; boundary="===============6572119168915865470=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: RE: [PATCH 3/4] nettime: Documentation
Date: Tue, 01 Feb 2011 21:58:48 +0200
Message-ID: <1296590328.2619.45.camel@tucson>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802DA147E@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6572119168915865470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On Tue, 2011-02-01 at 16:54 +0200, ext Jeevaka.Badrappan(a)elektrobit.com
wrote:
> > +			int32 DST [optional]
> > +				Current daylight saving setting in
> > +				hours.
> =

> few hours back I delivered a patch for converting the DST from hours to
> seconds in ofono driver code.
> are we going to take that into consideration?

Ah, well. Might as well then change the dst to be hours. Would you mind
resubmitting those patches, plus one that fixes struct
ofono_network_time as well?

Cheers,
Aki


--===============6572119168915865470==--

