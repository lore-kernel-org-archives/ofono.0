Content-Type: multipart/mixed; boundary="===============6319667291855609970=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/1] hfp: Add faked sim driver to support SIM ready
Date: Tue, 31 Aug 2010 08:58:43 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352A506B8D@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C7C0B8C.40702@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6319667291855609970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

> On 08/30/2010 04:50 AM, Zhenhua Zhang wrote:
>> HFP modem doesn't have IMSI at all. In order to notify SIM ready to
>> the core, we create a special sim driver with a faked IMSI number.
> =

> Can you try after commit 88024972df46d4ababbaf39354615e8a8d603cfc?  I
> added magic which will skip sim_ready stuff completely for modems
> that do not add a sim atom. =


Yes. Your patch works well and fixes the problem in a generic way.

> Regards,
> -Denis

Regards,
Zhenhua


--===============6319667291855609970==--

