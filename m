Content-Type: multipart/mixed; boundary="===============5110056555083849189=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: RE: [PATCH 1/5] cell-info: Header file for cell info atom
Date: Thu, 30 Dec 2010 17:33:50 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231CD1B72@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1293542847-24248-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5110056555083849189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>+struct ofono_cell_info_results {
>+	enum ofono_cell_type rat;
>+	uint16_t mcc;
>+	uint16_t mnc;
>+	union {
>+		struct geran geran;
>+		struct utran utran;
>+	};
>+};

Is there such a case that modem reports a GERAN serving cell info together =
with some UTRAN neighbouring cell infos?


Regards,
Wei, Jun =E9=9F=A6=E5=B3=BB
Email: jun.wei(a)intel.com =20

--===============5110056555083849189==--

