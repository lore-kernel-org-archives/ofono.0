Content-Type: multipart/mixed; boundary="===============4136368976466869617=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 1/2] stk: provide access technology info
Date: Thu, 18 Nov 2010 23:17:12 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702CCB3A0@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473306473C1@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4136368976466869617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Yang,
 =

> I think you're right. I'm not quite clear about the =

> difference. Could you help me clarify several questions? =

> Does it mean COPS only returns current available access =

> technology, while CREG returns current connected access technology?

COPS returns the currently available operators and its
corresponding access technologies. CREG returns the currently
registered operator's access techonology. In provide local
information as Jeeva mentioned we have to include only the current
registered access technology.

So the logic used in =

+static gboolean get_tech(struct ofono_stk *stk, struct stk_response
*rsp,
+							gboolean
singleton)
should also be changed apart from the
+unsigned int __ofono_netreg_get_tech(struct ofono_netreg *netreg)
change.
 =

> And if netreg->technology is used, what should be returned =

> once the multiple access technologies are requested? =


As said above, in this case only the current registered access =

technology should be returned and so irrespective of a platform
supporting multiple technologies, the currently registered access
technology will be only one type in a Single mode active case.

> It seems oFono only supports one connected technology.

Yes, currently only Single mode active case is supported.

> In which situation we can connect to multiple access =

> technologies simultaneously?

In Dual Mode Dual standby case. =


BR,
Rajesh

--===============4136368976466869617==--

