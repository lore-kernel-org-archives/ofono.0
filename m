Content-Type: multipart/mixed; boundary="===============2840676740587448745=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] hfp: Add faked sim driver to support SIM ready
Date: Mon, 30 Aug 2010 14:50:36 -0500
Message-ID: <4C7C0B8C.40702@gmail.com>
In-Reply-To: <1283161817-22935-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2840676740587448745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 08/30/2010 04:50 AM, Zhenhua Zhang wrote:
> HFP modem doesn't have IMSI at all. In order to notify SIM ready to the
> core, we create a special sim driver with a faked IMSI number.

Can you try after commit 88024972df46d4ababbaf39354615e8a8d603cfc?  I
added magic which will skip sim_ready stuff completely for modems that
do not add a sim atom.

Regards,
-Denis

--===============2840676740587448745==--

