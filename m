Content-Type: multipart/mixed; boundary="===============2578230822128737008=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 16:42:01 +0200
Message-ID: <201101141642.01738.remi.denis-courmont@nokia.com>
In-Reply-To: <1295014227.3873.144.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2578230822128737008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 14 January 2011 16:10:27 ext Marcel Holtmann, you wrote:
> > Yes, that is how our previous UIs have done it, and I guess our UX
> > designers like it in the future too.
> =

> I would advise the UI against using the name from the context
> information and better using the one from the network registration
> instead.

Well that would make sense... Therefore the operators don't do it ;-)

For instance my provider shows as "Elisa" in the network registration but t=
he =

access points are expected to be shown as "Elisa Internet" and "Elisa MMS W=
AP" =

if I recall correctly.

It only makes sense to have this data in the provisioning plugin. It would =
be =

silly to have to provision just the names in a different component.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============2578230822128737008==--

