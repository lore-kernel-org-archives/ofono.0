Content-Type: multipart/mixed; boundary="===============5789848124454661481=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 2/5 v3] Cell-info: Header file for Neighbor cell info
Date: Wed, 09 Feb 2011 08:54:42 +0200
Message-ID: <1297234482.8586.24.camel@apaila-ThinkPad-T410>
In-Reply-To: <1297107012.1520.446.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5789848124454661481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2011-02-07 at 11:30 -0800, ext Marcel Holtmann wrote:
> Hi Antti,
> =

> > +#define OFONO_CI_FIELD_TA_UNDEFINED 0xFF
> > +#define OFONO_CI_FIELD_UCID_UNDEFINED 0xFFFFFFFF
> > +#define OFONO_CI_FIELD_ECN0_UNDEFINED 0xFF
> > +#define OFONO_CI_FIELD_RSCP_UNDEFINED -127
> > +#define OFONO_CI_FIELD_PATHLOSS_UNDEFINED 0xFF
> > +#define OFONO_CI_FIELD_FREQ_UNDEFINED 0xFFFF
> > +
> > +#define OFONO_MAX_NMR_COUNT 15
> > +#define OFONO_MAX_MEASURED_CELL_COUNT 32
> > +#define OFONO_MAX_MEAS_RES_LIST_COUNT 8
> > +
> > +enum ofono_cell_type {
> > +	OFONO_CELL_TYPE_GERAN,
> > +	OFONO_CELL_TYPE_UTRAN_FDD
> > +};
> =

> anything we have to keep in mind for LTE here? Or does LTE not matter
> for neighbor cell info?

Neighbor cell info does matter for LTE. I quickly browsed through the
OMA spec and it seems that eutra follows the same format as geran and
utran. Have not had time to get the details yet.

Best Regards,
  Antti


--===============5789848124454661481==--

