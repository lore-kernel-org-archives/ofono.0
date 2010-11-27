Content-Type: multipart/mixed; boundary="===============1131037565883008605=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH 1/5] text-telephony: add public header
Date: Sat, 27 Nov 2010 13:04:55 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157E6BCB6@orsmsx508.amr.corp.intel.com>
In-Reply-To: <4CF00A15.3050302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1131037565883008605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > +	void (*remove)(struct ofono_ctm *tt);
> > +	void (*query_tty)(struct ofono_ctm *tt,
> > +				ofono_ctm_query_cb_t cb,
> > +				void *data);
> > +	void (*set_tty)(struct ofono_ctm *tt,
> > +				int enable,
>
> I also changed this to ofono_bool_t enable

Fyi, I noticed that radio-settings.h has this as an int as well:

67         void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
68                                 int enable,
69                                 ofono_radio_settings_fast_dormancy_set_c=
b_t,
70                                 void *data);

The query callback otoh uses ofono_bool_t.

Cheers,
Waldo

--===============1131037565883008605==--

