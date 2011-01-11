Content-Type: multipart/mixed; boundary="===============3287979859640370266=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 1/2] Expose voice call direction synchronously
Date: Tue, 11 Jan 2011 12:47:00 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4140D3601@008-AM1MPN1-002.mgdnok.nokia.com>
In-Reply-To: <1294673180-12845-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3287979859640370266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 10 Jan 2010, R=C3=A9mi Denis-Courmont wrote:
> Currently, the call direction can only be inferred from the signals.
> This adds a property to keep it visible also from GetCalls().

just adding one more do { ++votes; } while(0) for this.
telepathy-ring needs this as well when it is (re)started and there
are existing calls: =

https://bugs.freedesktop.org/show_bug.cgi?id=3D32990


--===============3287979859640370266==--

