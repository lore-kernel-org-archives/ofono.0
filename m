Content-Type: multipart/mixed; boundary="===============8947246963586200965=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH v2 0/5] Add support for PAP authentication
Date: Sun, 22 Jun 2014 11:33:48 +0200
Message-ID: <20140622093348.GQ33006@rincewind.trouble.is>
In-Reply-To: <53A5BCAD.9090707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8947246963586200965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-21 12:11:09 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> On 06/19/2014 05:07 AM, Philip Paeps wrote:
> > Changes since v1:
> > =

> >  o Split patchset into a commit per directory
> >  o Remove Signed-off-by: tags
> >  o Fix coding style nits
> >  o Use a counter instead of a random value for the
> >    Authenticate-Request identifer
> >  o Omit the provisioning code pending a discussion with
> >    the mobile-broadband-provider-info maintainers
> > =

> > Philip Paeps (5):
> >   gatchat: implement PAP authentication
> >   include: add auth method to the gprs context API
> >   atmodem: set the PPP authentication method to use
> >   gprs: make PPP authentication method configurable
> >   doc: describe the AuthenticationMethod property
> =

> All patches in this series have been applied, thanks!  I did fix up a
> couple of very minor coding style issues; just being nitpicky.
> =

> It was refreshing to review something this well prepared :)

Great!  Thanks Denis.

I've got a bug open with the mobile-broadband-providers-info
maintainers (https://bugzilla.gnome.org/show_bug.cgi?id=3D731907)
regarding the provisioning part of the authentication method.
When that gets resolved, I'll submit another patchset for that
code.

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============8947246963586200965==--

