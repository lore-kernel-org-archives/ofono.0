Content-Type: multipart/mixed; boundary="===============3805163339440360516=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Fix: Remove released call from call lists
Date: Mon, 16 Nov 2009 10:12:54 -0600
Message-ID: <200911161012.55291.denkenz@gmail.com>
In-Reply-To: <1258366845.24193.1.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3805163339440360516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> We should remove the released call from the list to avoid
> potiential double free problem.

The issue was actually in release_by_status.  Should now be fixed.

Regards,
-Denis

--===============3805163339440360516==--

