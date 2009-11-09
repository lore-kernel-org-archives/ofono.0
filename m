Content-Type: multipart/mixed; boundary="===============2739982229398777441=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: [PATCH */4] add interface property to primary context
Date: Mon, 09 Nov 2009 15:42:53 +0800
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D888EF02E@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <1257752281-22251-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2739982229398777441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi:
"Interface" property of Primary Context is needed by ofono plugin for Connm=
an.
These patches are used to implement "interface" property for Primary Contex=
t. Below is the way to implement it.
1.	Create "interface" in Primary Context creating =

2.	 Destroy "interface" in Primary Context destroying
3.	"interface" is created/destroyed by ofono_gprs_context_driver
   a)	"interface" of MBM is inherited from NetworkInterface of modem which =
is exported from kernel
   b)	Others can use ofono_gprs_context_driver->create/destroy_interface() =
to create/destroy interface such as ppp0 and tun0.
Please review it.

--===============2739982229398777441==--

