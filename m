Content-Type: multipart/mixed; boundary="===============1647840294469765731=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RFC: Neighbouring Cell Info, take 2
Date: Wed, 10 Feb 2010 16:23:18 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BD5781EA@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1647840294469765731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Revisited proposal for neighbouring cell info based on previous feedback:
- Low-level driver API instead of oFono.org DBUS API =

- Polling based, no automatic periodic updates
- Follows definitions in OMA SUPL v2.0

I'm not particular fond of the nested list -> wcdma. measured_results_list[=
].cell_measured_results[], maybe flatten that into a single list?

Cheers,
Waldo

/*
 *
 *  oFono - Open Source Telephony
 *
 *  Copyright (C) 2010 Intel Corporation.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 *
 */

#ifndef __OFONO_CELL_INFO_H
#define __OFONO_CELL_INFO_H

#ifdef __cplusplus
extern "C" {
#endif

#include <ofono/types.h>

struct ofono_cell_info;

enum ofono_cell_info_type {
	OFONO_CELL_INFO_GSM =3D 0,
	OFONO_CELL_INFO_WCDMA =3D 1,
};


struct ofono_cell_info_results {
	enum ofono_cell_info_type rat;
	char mcc[OFONO_MAX_MCC_LENGTH + 1];
	char mnc[OFONO_MAX_MNC_LENGTH + 1];
	union {
		struct {
			int lac;	/* Location Area Code (0.65535) */ =

			int ci;		/* Cell Identity (0..65535) */
			int ta; 	/* Timing Advance (0..255), -1 =3D unsupported */
			int no_cells;	/* Number of valid nmr entries (1..15) */
			struct {
				int arfcn; /* ARFCN of the channel (0..1023) */
				int bsic;  /* BSIC of the channel (0..63) */
				int rxlev; /* Measured power of the channel (0..63) Subtract 110 to get=
 power in dBm */
			} nmr[15];
		} gsm;
		=

		struct {
			int uc;			/* Cell Identity, composed of RNC-ID and C-ID (0..268435455) */
			int dl_frequency;	/* (0..16383), -1 =3D unsupported */
			int ul_frequency;	/* (0..16383), -1 =3D unsupported */
			int scrambling_code;	/* Primary scrambling code (0..511) */
			int no_freq;		/* Number of valid measured_results_list entries (1..8) */=
 			=

			struct {
				int dl_frequency;	/* (0..16383), -1 =3D unsupported */
				int ul_frequency;	/* (0..16383), -1 =3D unsupported */
				int rssi;		/* UTRA-CarrierRSSI (0..76), -1 =3D unsupported */
				int no_cells;		/* Number of valid cell_measured_results entries (0..32)=
 */
				struct {
					int ci; 	/* Cell Identity (0..268435455), -1 =3D unsupported */
					int scrambling_code; /* Primary scrambling code (0..511) */
					int ecn0;	/* (0..49), -1 =3D unsupported */
					int rscp;	/* cpich-RSCP per [3GPP RRC] (0..127), -1 =3D unsupported */
					int pathloss;	/* (46..158), -1 =3D unsupported */
				} cell_measured_results[32];
			} measured_results_list[8];
		} wcdma;
	};
};

typedef void (*ofono_cell_info_query_cb_t)(const struct ofono_error *error,
						const struct ofono_cell_info_results results,
						void *data);

struct ofono_cell_info_driver {
	const char *name;
	int (*probe)(struct ofono_cell_info *ci, unsigned int vendor,
			void *data);
	void (*remove)(struct ofono_cell_info *ci);
	void (*query)(struct ofono_cell_info *ci,
			ofono_cell_info_query_cb_t cb,
			void *data);
};

void ofono_cell_info_query(struct ofono_cell_info *ci, ofono_cell_info_quer=
y_cb_t cb, void *data);

int ofono_cell_info_driver_register(const struct ofono_cell_info_driver *d);
void ofono_cel_info_driver_unregister(const struct ofono_cell_info_driver *=
d);

struct ofono_cell_info *ofono_cell_info_create(struct ofono_modem *modem,
								unsigned int vendor,
								const char *driver,
								void *data);

void ofono_cell_info_register(struct ofono_cell_info *ci);
void ofono_cell_info_remove(struct ofono_cell_info *ci);

void ofono_cell_info_set_data(struct ofono_radio_settings *ci, void *data);
void *ofono_cell_info_get_data(struct ofono_radio_settings *ci);

#ifdef __cplusplus
}
#endif

#endif /* __OFONO_CELL_INFO_H */


Cheers,
Waldo
-- =

Intel Corporation - Hillsboro, Oregon
Ultra Mobility Group - Platform Software Architecture
Tel: +1 503 264 6237 - Mobile: +1 503 703-7327

--===============1647840294469765731==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cell-info.h"

LyoKICoKICogIG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBob255CiAqCiAqICBDb3B5cmlnaHQg
KEMpIDIwMTAgSW50ZWwgQ29ycG9yYXRpb24uCiAqCiAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogKiAgaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIg
YXMKICogIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgogKgogKiAg
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1
c2VmdWwsCiAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1w
bGllZCB3YXJyYW50eSBvZgogKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFS
VElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQogKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
Zm9yIG1vcmUgZGV0YWlscy4KICoKICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiAqICBhbG9uZyB3aXRoIHRoaXMgcHJv
Z3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQogKiAgRm91bmRhdGlvbiwg
SW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BICAwMjExMC0xMzAx
ICBVU0EKICoKICovCgojaWZuZGVmIF9fT0ZPTk9fQ0VMTF9JTkZPX0gKI2RlZmluZSBfX09GT05P
X0NFTExfSU5GT19ICgojaWZkZWYgX19jcGx1c3BsdXMKZXh0ZXJuICJDIiB7CiNlbmRpZgoKI2lu
Y2x1ZGUgPG9mb25vL3R5cGVzLmg+CgpzdHJ1Y3Qgb2Zvbm9fY2VsbF9pbmZvOwoKZW51bSBvZm9u
b19jZWxsX2luZm9fdHlwZSB7CglPRk9OT19DRUxMX0lORk9fR1NNID0gMCwKCU9GT05PX0NFTExf
SU5GT19XQ0RNQSA9IDEsCn07CgoKc3RydWN0IG9mb25vX2NlbGxfaW5mb19yZXN1bHRzIHsKCWVu
dW0gb2Zvbm9fY2VsbF9pbmZvX3R5cGUgcmF0OwoJY2hhciBtY2NbT0ZPTk9fTUFYX01DQ19MRU5H
VEggKyAxXTsKCWNoYXIgbW5jW09GT05PX01BWF9NTkNfTEVOR1RIICsgMV07Cgl1bmlvbiB7CgkJ
c3RydWN0IHsKCQkJaW50IGxhYzsJLyogTG9jYXRpb24gQXJlYSBDb2RlICgwLjY1NTM1KSAqLyAK
CQkJaW50IGNpOwkJLyogQ2VsbCBJZGVudGl0eSAoMC4uNjU1MzUpICovCgkJCWludCB0YTsgCS8q
IFRpbWluZyBBZHZhbmNlICgwLi4yNTUpLCAtMSA9IHVuc3VwcG9ydGVkICovCgkJCWludCBub19j
ZWxsczsJLyogTnVtYmVyIG9mIHZhbGlkIG5tciBlbnRyaWVzICgxLi4xNSkgKi8KCQkJc3RydWN0
IHsKCQkJCWludCBhcmZjbjsgLyogQVJGQ04gb2YgdGhlIGNoYW5uZWwgKDAuLjEwMjMpICovCgkJ
CQlpbnQgYnNpYzsgIC8qIEJTSUMgb2YgdGhlIGNoYW5uZWwgKDAuLjYzKSAqLwoJCQkJaW50IHJ4
bGV2OyAvKiBNZWFzdXJlZCBwb3dlciBvZiB0aGUgY2hhbm5lbCAoMC4uNjMpIFN1YnRyYWN0IDEx
MCB0byBnZXQgcG93ZXIgaW4gZEJtICovCgkJCX0gbm1yWzE1XTsKCQl9IGdzbTsKCQkKCQlzdHJ1
Y3QgewoJCQlpbnQgdWM7CQkJLyogQ2VsbCBJZGVudGl0eSwgY29tcG9zZWQgb2YgUk5DLUlEIGFu
ZCBDLUlEICgwLi4yNjg0MzU0NTUpICovCgkJCWludCBkbF9mcmVxdWVuY3k7CS8qICgwLi4xNjM4
MyksIC0xID0gdW5zdXBwb3J0ZWQgKi8KCQkJaW50IHVsX2ZyZXF1ZW5jeTsJLyogKDAuLjE2Mzgz
KSwgLTEgPSB1bnN1cHBvcnRlZCAqLwoJCQlpbnQgc2NyYW1ibGluZ19jb2RlOwkvKiBQcmltYXJ5
IHNjcmFtYmxpbmcgY29kZSAoMC4uNTExKSAqLwoJCQlpbnQgbm9fZnJlcTsJCS8qIE51bWJlciBv
ZiB2YWxpZCBtZWFzdXJlZF9yZXN1bHRzX2xpc3QgZW50cmllcyAoMS4uOCkgKi8gCQkJCgkJCXN0
cnVjdCB7CgkJCQlpbnQgZGxfZnJlcXVlbmN5OwkvKiAoMC4uMTYzODMpLCAtMSA9IHVuc3VwcG9y
dGVkICovCgkJCQlpbnQgdWxfZnJlcXVlbmN5OwkvKiAoMC4uMTYzODMpLCAtMSA9IHVuc3VwcG9y
dGVkICovCgkJCQlpbnQgcnNzaTsJCS8qIFVUUkEtQ2FycmllclJTU0kgKDAuLjc2KSwgLTEgPSB1
bnN1cHBvcnRlZCAqLwoJCQkJaW50IG5vX2NlbGxzOwkJLyogTnVtYmVyIG9mIHZhbGlkIGNlbGxf
bWVhc3VyZWRfcmVzdWx0cyBlbnRyaWVzICgwLi4zMikgKi8KCQkJCXN0cnVjdCB7CgkJCQkJaW50
IGNpOyAJLyogQ2VsbCBJZGVudGl0eSAoMC4uMjY4NDM1NDU1KSwgLTEgPSB1bnN1cHBvcnRlZCAq
LwoJCQkJCWludCBzY3JhbWJsaW5nX2NvZGU7IC8qIFByaW1hcnkgc2NyYW1ibGluZyBjb2RlICgw
Li41MTEpICovCgkJCQkJaW50IGVjbjA7CS8qICgwLi40OSksIC0xID0gdW5zdXBwb3J0ZWQgKi8K
CQkJCQlpbnQgcnNjcDsJLyogY3BpY2gtUlNDUCBwZXIgWzNHUFAgUlJDXSAoMC4uMTI3KSwgLTEg
PSB1bnN1cHBvcnRlZCAqLwoJCQkJCWludCBwYXRobG9zczsJLyogKDQ2Li4xNTgpLCAtMSA9IHVu
c3VwcG9ydGVkICovCgkJCQl9IGNlbGxfbWVhc3VyZWRfcmVzdWx0c1szMl07CgkJCX0gbWVhc3Vy
ZWRfcmVzdWx0c19saXN0WzhdOwoJCX0gd2NkbWE7Cgl9Owp9OwoKdHlwZWRlZiB2b2lkICgqb2Zv
bm9fY2VsbF9pbmZvX3F1ZXJ5X2NiX3QpKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3Is
CgkJCQkJCWNvbnN0IHN0cnVjdCBvZm9ub19jZWxsX2luZm9fcmVzdWx0cyByZXN1bHRzLAoJCQkJ
CQl2b2lkICpkYXRhKTsKCnN0cnVjdCBvZm9ub19jZWxsX2luZm9fZHJpdmVyIHsKCWNvbnN0IGNo
YXIgKm5hbWU7CglpbnQgKCpwcm9iZSkoc3RydWN0IG9mb25vX2NlbGxfaW5mbyAqY2ksIHVuc2ln
bmVkIGludCB2ZW5kb3IsCgkJCXZvaWQgKmRhdGEpOwoJdm9pZCAoKnJlbW92ZSkoc3RydWN0IG9m
b25vX2NlbGxfaW5mbyAqY2kpOwoJdm9pZCAoKnF1ZXJ5KShzdHJ1Y3Qgb2Zvbm9fY2VsbF9pbmZv
ICpjaSwKCQkJb2Zvbm9fY2VsbF9pbmZvX3F1ZXJ5X2NiX3QgY2IsCgkJCXZvaWQgKmRhdGEpOwp9
OwoKdm9pZCBvZm9ub19jZWxsX2luZm9fcXVlcnkoc3RydWN0IG9mb25vX2NlbGxfaW5mbyAqY2ks
IG9mb25vX2NlbGxfaW5mb19xdWVyeV9jYl90IGNiLCB2b2lkICpkYXRhKTsKCmludCBvZm9ub19j
ZWxsX2luZm9fZHJpdmVyX3JlZ2lzdGVyKGNvbnN0IHN0cnVjdCBvZm9ub19jZWxsX2luZm9fZHJp
dmVyICpkKTsKdm9pZCBvZm9ub19jZWxfaW5mb19kcml2ZXJfdW5yZWdpc3Rlcihjb25zdCBzdHJ1
Y3Qgb2Zvbm9fY2VsbF9pbmZvX2RyaXZlciAqZCk7CgpzdHJ1Y3Qgb2Zvbm9fY2VsbF9pbmZvICpv
Zm9ub19jZWxsX2luZm9fY3JlYXRlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sCgkJCQkJCQkJ
dW5zaWduZWQgaW50IHZlbmRvciwKCQkJCQkJCQljb25zdCBjaGFyICpkcml2ZXIsCgkJCQkJCQkJ
dm9pZCAqZGF0YSk7Cgp2b2lkIG9mb25vX2NlbGxfaW5mb19yZWdpc3RlcihzdHJ1Y3Qgb2Zvbm9f
Y2VsbF9pbmZvICpjaSk7CnZvaWQgb2Zvbm9fY2VsbF9pbmZvX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9f
Y2VsbF9pbmZvICpjaSk7Cgp2b2lkIG9mb25vX2NlbGxfaW5mb19zZXRfZGF0YShzdHJ1Y3Qgb2Zv
bm9fcmFkaW9fc2V0dGluZ3MgKmNpLCB2b2lkICpkYXRhKTsKdm9pZCAqb2Zvbm9fY2VsbF9pbmZv
X2dldF9kYXRhKHN0cnVjdCBvZm9ub19yYWRpb19zZXR0aW5ncyAqY2kpOwoKI2lmZGVmIF9fY3Bs
dXNwbHVzCn0KI2VuZGlmCgojZW5kaWYgLyogX19PRk9OT19DRUxMX0lORk9fSCAqLwo=

--===============1647840294469765731==--

