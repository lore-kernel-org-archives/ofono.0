Content-Type: multipart/mixed; boundary="===============6314911723386211771=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 2/6] stemodem: add default case
Date: Tue, 26 Oct 2010 17:43:23 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7DBDF5BA@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1288107326.3613.22.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6314911723386211771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > diff --git a/drivers/stemodem/radio-settings.c =

> b/drivers/stemodem/radio-settings.c
> > index 5b16ec0..a345975 100644
> > --- a/drivers/stemodem/radio-settings.c
> > +++ b/drivers/stemodem/radio-settings.c
> > @@ -90,7 +90,7 @@ static gboolean =

> ofono_mode_to_ste_mode(enum ofono_radio_access_mode mode,
> >  	case OFONO_RADIO_ACCESS_MODE_UMTS:
> >  		*stemode =3D STE_RADIO_WCDMA_ONLY;
> >  		return TRUE;
> > -	case OFONO_RADIO_ACCESS_MODE_LTE:
> > +	default:
> >  		break;
> =

> no default for enums please. I want the compiler to warn us about not
> handled switch statements.

That must be a new policy then, considering that stemodem is the only one t=
hat failed compilation. Feel free to fix this one. The first two patches in=
 the set are unrelated to fast dormancy anyway.

Br,

	MikaL

--===============6314911723386211771==--

