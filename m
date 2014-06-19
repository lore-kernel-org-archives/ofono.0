Content-Type: multipart/mixed; boundary="===============7927436146357990993=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH 3/3] mbpi: add authentication methods to provisioning
Date: Thu, 19 Jun 2014 10:34:15 +0200
Message-ID: <20140619083415.GB33006@rincewind.trouble.is>
In-Reply-To: <53A213D5.1030308@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7927436146357990993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-18 17:33:57 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> On 06/17/2014 04:57 PM, Philip Paeps wrote:
> > +	else if (g_str_equal(element_name, "auth"))
> > +		usage_authmethod(context, attribute_names, attribute_values,
> > +						&apn->auth_method, error);
> =

> I don't see this element in the DTD definition in
> mobile-broadband-provider-info tree.  Has this been proposed / approved
> there yet?

It has not and I've not discussed it there either.  I wasn't aware they
are a different project.  I'll omit the provisioning code from my
updated patchset and submit it separately if and when there is support
for it in the mobile-broadband-provider-info tree.

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============7927436146357990993==--

