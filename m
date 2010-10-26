Content-Type: multipart/mixed; boundary="===============2966575433206440156=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 2/6] stemodem: add default case
Date: Tue, 26 Oct 2010 18:24:55 +0200
Message-ID: <1288110295.3613.25.camel@aeonflux>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7DBDF5BA@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2966575433206440156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > > diff --git a/drivers/stemodem/radio-settings.c =

> > b/drivers/stemodem/radio-settings.c
> > > index 5b16ec0..a345975 100644
> > > --- a/drivers/stemodem/radio-settings.c
> > > +++ b/drivers/stemodem/radio-settings.c
> > > @@ -90,7 +90,7 @@ static gboolean =

> > ofono_mode_to_ste_mode(enum ofono_radio_access_mode mode,
> > >  	case OFONO_RADIO_ACCESS_MODE_UMTS:
> > >  		*stemode =3D STE_RADIO_WCDMA_ONLY;
> > >  		return TRUE;
> > > -	case OFONO_RADIO_ACCESS_MODE_LTE:
> > > +	default:
> > >  		break;
> > =

> > no default for enums please. I want the compiler to warn us about not
> > handled switch statements.
> =

> That must be a new policy then, considering that stemodem is the only one=
 that failed compilation. Feel free to fix this one. The first two patches =
in the set are unrelated to fast dormancy anyway.

that is the whole point here. You modified the enum and the compilation
should fail unless you add a statement for that new item.

Let me make this clear, I do want the compilation to fail here and the
STE driver is doing the right thing.

There might be other cases where this is not consistent. I would prefer
if that never happens, but somethings things slip through even close
code review. If you know other cases, please let me know and we fix them
as well here.

Regards

Marcel



--===============2966575433206440156==--

