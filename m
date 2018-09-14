Content-Type: multipart/mixed; boundary="===============6356031810885690473=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: vendor models and options
Date: Fri, 14 Sep 2018 01:00:38 -0500
Message-ID: <a89fd0a7-4cf7-5292-ffba-00422e0589f3@gmail.com>
In-Reply-To: <CAKSBH7EapnjrN2c6J-M9zFS5kYL9rbYRjKRw6LJHiEEjYkBTiQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6356031810885690473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

So first of all, please stop top-posting on this mailing list.  All =

comments should be in-line.

> enum gemalto_auth_type {
> OV_GEMALTO_AUTH_CGAUTH =3D 0,

CGAUTH is a release 11 feature and should be simply probed for in the =

gprs-context initialization procedure, similar to how we test for =

+CGDATA support.

> OV_GEMALTO_AUTH_SGAUTH_PWD_USER =3D 1,
> OV_GEMALTO_AUTH_SGAUTH_USER_PWD =3D 2,

You will need to explain the difference between SGAUTH 1 & 2 to me.  Is =

it the parameter order that is different between firmware versions? =

Can't these simply be queried properly using AT^SGAUTH=3D?

> };

So are you introducing a new gprs-context driver for gemalto or using =

these for the 'atmodem' driver?

> =

> struct ov_gemalto {
> enum gemalto_auth_type auth;
> gboolean vts_with_quotes;

Sheesh, your firmware guys somehow managed to screw up the VTS command =

syntax?  That command has been in there for 20 years...

Anyhow, I strongly discourage you from modifying the atmodem voicecall.c =

driver.  Every vendor should have voice call state reporting commands =

that are far superior to the AT+CLCC polling we do in the 'atmodem' =

voicecall.c driver.  So it should be fairly trivial to probe for +VTS =

syntax there.

Worst case you can use ofono_modem_set_* family to set a particular =

modem specific property which can be available to all atom drivers via =

ofono_modem_get_*.  So this VTS syntax can be handled that way.

> };
> =


<snip>

> =

> and then change the *_create() functions to use 'struct =

> ofono_vendor_parameters *' instead of 'unsigned int vendor', with =

> default &ov_generic.
> =

> In the example above, I have shown differences for the various Gemalto =

> authentication commands (3 options), that=C2=A0 cross with the options fo=
r VTS.
> And then most of the settings are common for Gemalto models (currently =

> factored with the vendor=3DOFONO_VENDOR_CINTERION).
> If=C2=A0 tomorrow I have to declare models for these simple settings, I h=
ave =

> to add at least 6 with the current system, and having a full driver just =

> because of these two AT commands seems needless.

No, this is all completely unneeded as far as I'm concerned.  If you =

want to use +CGAUTH, then just probe it properly and don't pass a vendor =

at all.  The VTS stuff I already covered.

> =

> The code would be simplified because in general in a switch there will =

> be only 1 vendor, with the current system there would be 6.
> =

> Is it ok if I update the code with this vendor system? I will have to =

> submit the entire tree, not by subdirectories, to have a consistent and =

> compiling commit.
> =


Right now I'm completely unconvinced that such an invasive change is =

warranted.  So no, please don't do this.

Regards,
-Denis

--===============6356031810885690473==--

