Content-Type: multipart/mixed; boundary="===============3815746748960500999=="
MIME-Version: 1.0
From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: [PATCH] Allow override of phonesim conf
Date: Wed, 26 Mar 2014 13:26:49 +0200
Message-ID: <5332B979.1010604@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3815746748960500999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

Currently phonesim tries to open its conf file from the location =

specified at configure time (/etc/ofono/phonesim.conf). For testing =

purposes it would be nice to be able to override this. This patch allows =

you to override the location with the environment variable =

OFONO_PHONESIM_CONFIG.

Thanks,

--===============3815746748960500999==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config_override.patch"

ZGlmZiAtLWdpdCBhL3BsdWdpbnMvcGhvbmVzaW0uYyBiL3BsdWdpbnMvcGhvbmVzaW0uYwppbmRl
eCA5MThkMmViLi45OTFhYWVhIDEwMDY0NAotLS0gYS9wbHVnaW5zL3Bob25lc2ltLmMKKysrIGIv
cGx1Z2lucy9waG9uZXNpbS5jCkBAIC0xMDcxLDcgKzEwNzEsNyBAQCBkb25lOgogc3RhdGljIGlu
dCBwaG9uZXNpbV9pbml0KHZvaWQpCiB7CiAJaW50IGVycjsKLQorCWNoYXIgKmNvbmZfb3ZlcnJp
ZGUgPSBnZXRlbnYoIk9GT05PX1BIT05FU0lNX0NPTkZJRyIpOwogCWVyciA9IG9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigmcGhvbmVzaW1fZHJpdmVyKTsKIAlpZiAoZXJyIDwgMCkKIAkJcmV0
dXJuIGVycjsKQEAgLTEwODEsNyArMTA4MSwxMSBAQCBzdGF0aWMgaW50IHBob25lc2ltX2luaXQo
dm9pZCkKIAlvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCZjb250ZXh0X2RyaXZl
cik7CiAJb2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigmY3RtX2RyaXZlcik7CiAKLQlwYXJzZV9j
b25maWcoQ09ORklHRElSICIvcGhvbmVzaW0uY29uZiIpOworCWlmKGNvbmZfb3ZlcnJpZGUpIHsK
KwkJcGFyc2VfY29uZmlnKGNvbmZfb3ZlcnJpZGUpOworCX0gZWxzZSB7CisJCXBhcnNlX2NvbmZp
ZyhDT05GSUdESVIgIi9waG9uZXNpbS5jb25mIik7CisJfQogCiAJcmV0dXJuIDA7CiB9Cg==

--===============3815746748960500999==--

