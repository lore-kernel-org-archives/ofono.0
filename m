Content-Type: multipart/mixed; boundary="===============2368187664017788555=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] ppp: implement Max-Failure counter
Date: Fri, 02 Apr 2010 22:35:32 -0700
Message-ID: <20100402223532.4dbbf350@kcaccard-MOBL3>
In-Reply-To: <1270272420-4468-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2368187664017788555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri,  2 Apr 2010 22:27:00 -0700
Kristen Carlson Accardi <kristen@linux.intel.com> wrote:

> put a cap on the number of Configure-Nak packets we send.

Denis - did you have a modem that just went off into a flurry of
sending Configure-Naks?  If so, would you mind testing this patch
on it to see if this helps it accept defeat more gracefully?

Thanks.

--===============2368187664017788555==--

