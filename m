Content-Type: multipart/mixed; boundary="===============3626808459532630464=="
MIME-Version: 1.0
From: Pargada, Carlos <carlos.pargada@intel.com>
Subject: RE: Call Barring and MMI Supplementary Service codes
Date: Tue, 19 Oct 2010 12:37:16 +0100
Message-ID: <2A84145621092446B6659B8A0F28E26F46FE8E432C@irsmsx501.ger.corp.intel.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702B72E8A@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3626808459532630464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

> What values are expected from MMI services 25, 24 and 26?

> For MMI 22 (All Sync Services)=3D> 80 ("All data circuit sync" (16) + "All
> dedicated packet access" (64))

> For MMI 21 (All Async Services)=3D> 160 ("All data circuit async" (32) +
> "All dedicated PAD access" (128)).

> For MMI 26 (Telephony and All sync services)=3D> 81 (Telephony (1) + "All
> data circuit sync" (16) + "All dedicated packet access" (64))

> For MMI 24 (All data circuit sync)=3D> 16 ("All data circuit sync")

> For MMI 25 (All data circuit async)=3D> 32 ("All data circuit async")

I confirm your analyze for translation between MMI code services and classx=
 parameters for CLCK AT command. =

Assuming that dedicated packet access is an synchronous services and dedica=
ted PAD access is an asynchronous services (2204-491, replaced by 2204)


MMI     group           oFono current translate table
10	[1 to 6,12]		BEARER_CLASS_VOICE | BEARER_CLASS_FAX | BEARER_CLASS_SMS	1 =
+ 4 + 8	OK
11	[1        ]		BEARER_CLASS_VOICE							1		OK
12	[2 to 6   ]		BEARER_CLASS_SMS | BEARER_CLASS_FAX					4 + 8		OK
13	[6        ]		BEARER_CLASS_FAX								4		OK
16	[2        ]		BEARER_CLASS_SMS								8		OK
	=

	=

19	[1, 3 to 6, 12]	BEARER_CLASS_VOICE | BEARER_CLASS_FAX				1 + 4		OK
20	[7 to 11      ]	BEARER_CLASS_DATA_ASYNC | BEARER_CLASS_DATA_SYNC		16 + 3=
2	to be replace by  16 + 32 + 64 + 128
21	[7            ]	BEARER_CLASS_DATA_ASYNC							32		to be replace by	32 + =
128			=

22	[8            ]	BEARER_CLASS_DATA_SYNC							16		to be replace by	16 + 6=
4		=

24	[8            ]	BEARER_CLASS_DATA_SYNC							16		OK			=

25	[7            ]	BEARER_CLASS_DATA_ASYNC							32		OK				=

26	[1,8          ]	BEARER_CLASS_VOICE | BEARER_CLASS_DATA_SYNC			1 + 16	to =
be replace by	 1 + 16+ 64             =


I suggest to introduce you proposal on MMI 21, 22, 26 and also add changes =
on MMI 20 =



Regards

Carlos


---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3626808459532630464==--

