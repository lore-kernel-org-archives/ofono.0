Content-Type: multipart/mixed; boundary="===============6716159873049186514=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 19:01:03 +0530
Message-ID: <COL106-W65AFE01F9875AAF3ED3F84F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6716159873049186514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

After starting ofonod with command "sudo ofonod -n -d", I am getting below =
messages

Reading of /etc/ofono/modem.conf failed: Key file contains line 'pcm.!phone=
line {' which is not a key-value pair, group, or comment

Does it mean that it is not able to recognize the modem presented in modem.=
conf file?

if i try to execute ./list-modems then it is listing any thing. Please sugg=
est me.

modem.conf file contents
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------

#
# "raw" modem - phoneline
#

pcm.!phoneline {
    @args [ CARD DEV ]
    @args.CARD {
        type string
        default {
            @func getenv
            vars [
                ALSA_MODEM_CARD
                ALSA_PCM_CARD
                ALSA_CARD
            ]
            default {
                @func refer
                name defaults.pcm.modem.card
            }
        }
    }
    @args.DEV {
        type integer
        default {
            @func igetenv
            vars [
                ALSA_MODEM_DEVICE
            ]
            default {
                @func refer
                name defaults.pcm.modem.device
            }
        }
    }
    @func refer
    name {
        @func concat
        strings [
            "cards."
            {
                @func card_driver
                card $CARD
            }
            ".pcm.modem." $DEV ":CARD=3D" $CARD
        ]
    }
    hint.show off
}

#
#  "autohooked" modem
#

pcm.!modem {
    @args [ CARD DEV ]
    @args.CARD {
        type string
        default {
            @func getenv
            vars [
                ALSA_MODEM_CARD
                ALSA_PCM_CARD
                ALSA_CARD
            ]
            default {
                @func refer
                name defaults.pcm.modem.card
            }
        }
    }
    @args.DEV {
        type integer
        default {
            @func igetenv
            vars [
                ALSA_MODEM_DEVICE
            ]
            default {
                @func refer
                name defaults.pcm.modem.device
            }
        }
    }
    type hooks
    slave {
        pcm {
            @func concat
            strings [
                "cards.pcm.phoneline:CARD=3D" $CARD ",DEV=3D" $DEV
            ]
        }
    }
    hooks.0 {
        type ctl_elems
        hook_args [
        {
            name "Off-hook Switch"
            preserve true
            value "on"
            lock false
            optional true
        }
        ]
    }
    hint.show off
}

#
#Sample for using phone simulator
#
[phonesim]
Driver=3Dphonesim
Address=3D127.0.0.1
port=3D12345

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------

Thanks and Regards,
Krishna K Kandula
 		 	   		  =

_________________________________________________________________
The amazing world in sharp snaps
http://news.in.msn.com/gallery/archive.aspx

--===============6716159873049186514==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGks
PGJyPjxicj5BZnRlciBzdGFydGluZyBvZm9ub2Qgd2l0aCBjb21tYW5kICI8Yj5zdWRvIG9mb25v
ZCAtbiAtZDwvYj4iLCBJIGFtIGdldHRpbmcgYmVsb3cgbWVzc2FnZXM8YnI+PGJyPlJlYWRpbmcg
b2YgL2V0Yy9vZm9uby9tb2RlbS5jb25mIGZhaWxlZDogS2V5IGZpbGUgY29udGFpbnMgbGluZSAn
cGNtLiFwaG9uZWxpbmUgeycgd2hpY2ggaXMgbm90IGEga2V5LXZhbHVlIHBhaXIsIGdyb3VwLCBv
ciBjb21tZW50PGJyPjxicj5Eb2VzIGl0IG1lYW4gdGhhdCBpdCBpcyBub3QgYWJsZSB0byByZWNv
Z25pemUgdGhlIG1vZGVtIHByZXNlbnRlZCBpbiBtb2RlbS5jb25mIGZpbGU/PGJyPjxicj5pZiBp
IHRyeSB0byBleGVjdXRlIC4vbGlzdC1tb2RlbXMgdGhlbiBpdCBpcyBsaXN0aW5nIGFueSB0aGlu
Zy4gUGxlYXNlIHN1Z2dlc3QgbWUuPGJyPjxicj5tb2RlbS5jb25mIGZpbGUgY29udGVudHM8YnI+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj48YnI+Izxicj4jICJyYXciIG1vZGVtIC0gcGhvbmVsaW5lPGJyPiM8YnI+PGJy
PnBjbS4hcGhvbmVsaW5lIHs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEBhcmdzIFsgQ0FSRCBERVYg
XTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgQGFyZ3MuQ0FSRCB7PGJyPiZuYnNwOyZuYnNwOyZuYnNw
OyAmbmJzcDsmbmJzcDsmbmJzcDsgdHlwZSBzdHJpbmc8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZu
YnNwOyZuYnNwOyZuYnNwOyBkZWZhdWx0IHs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgQGZ1bmMgZ2V0ZW52PGJyPiZuYnNwOyZuYnNw
OyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IHZhcnMgWzxicj4m
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgQUxTQV9NT0RFTV9DQVJEPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBB
TFNBX1BDTV9DQVJEPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5i
c3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBBTFNBX0NBUkQ8YnI+Jm5ic3A7Jm5i
c3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgXTxicj4mbmJz
cDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBkZWZh
dWx0IHs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJz
cDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IEBmdW5jIHJlZmVyPGJyPiZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZu
YnNwOyBuYW1lIGRlZmF1bHRzLnBjbS5tb2RlbS5jYXJkPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7ICZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyBAYXJncy5ERVYgezxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5i
c3A7Jm5ic3A7IHR5cGUgaW50ZWdlcjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7
Jm5ic3A7IGRlZmF1bHQgezxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7
ICZuYnNwOyZuYnNwOyZuYnNwOyBAZnVuYyBpZ2V0ZW52PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IHZhcnMgWzxicj4mbmJzcDsmbmJz
cDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJz
cDsmbmJzcDsgQUxTQV9NT0RFTV9ERVZJQ0U8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgXTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5i
c3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBkZWZhdWx0IHs8YnI+Jm5ic3A7Jm5i
c3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5i
c3A7Jm5ic3A7IEBmdW5jIHJlZmVyPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsm
bmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBuYW1lIGRlZmF1bHRz
LnBjbS5tb2RlbS5kZXZpY2U8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNw
OyAmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7
Jm5ic3A7IH08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEBm
dW5jIHJlZmVyPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBuYW1lIHs8YnI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBAZnVuYyBjb25jYXQ8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICZuYnNwOyZuYnNwOyZuYnNwOyBzdHJpbmdzIFs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNw
OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgImNhcmRzLiI8YnI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgezxicj4mbmJzcDsm
bmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsm
bmJzcDsmbmJzcDsgQGZ1bmMgY2FyZF9kcml2ZXI8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNw
OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IGNhcmQg
JENBUkQ8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJz
cDsmbmJzcDsgfTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNw
OyZuYnNwOyZuYnNwOyAiLnBjbS5tb2RlbS4iICRERVYgIjpDQVJEPSIgJENBUkQ8YnI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBdPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyB9
PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBoaW50LnNob3cgb2ZmPGJyPn08YnI+PGJyPiM8YnI+IyZu
YnNwOyAiYXV0b2hvb2tlZCIgbW9kZW08YnI+Izxicj48YnI+cGNtLiFtb2RlbSB7PGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyBAYXJncyBbIENBUkQgREVWIF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEBh
cmdzLkNBUkQgezxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IHR5cGUg
c3RyaW5nPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgZGVmYXVsdCB7
PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5i
c3A7IEBmdW5jIGdldGVudjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7
ICZuYnNwOyZuYnNwOyZuYnNwOyB2YXJzIFs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IEFMU0FfTU9E
RU1fQ0FSRDxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgQUxTQV9QQ01fQ0FSRDxicj4mbmJzcDsmbmJz
cDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJz
cDsmbmJzcDsgQUxTQV9DQVJEPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJz
cDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNw
OyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgZGVmYXVsdCB7PGJyPiZuYnNwOyZuYnNwOyZuYnNw
OyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNw
OyBAZnVuYyByZWZlcjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZu
YnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgbmFtZSBkZWZhdWx0cy5wY20ubW9k
ZW0uY2FyZDxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyZuYnNwOyB9PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgfTxi
cj4mbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgQGFyZ3MuREVWIHs8
YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyB0eXBlIGludGVnZXI8YnI+
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBkZWZhdWx0IHs8YnI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgQGZ1bmMg
aWdldGVudjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyZuYnNwOyB2YXJzIFs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNw
OyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IEFMU0FfTU9ERU1fREVWSUNF
PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5i
c3A7IF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJz
cDsmbmJzcDsgZGVmYXVsdCB7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJz
cDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBAZnVuYyByZWZlcjxicj4m
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgbmFtZSBkZWZhdWx0cy5wY20ubW9kZW0uZGV2aWNlPGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPiZuYnNwOyZuYnNwOyZu
YnNwOyB9PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyB0eXBlIGhvb2tzPGJyPiZuYnNwOyZuYnNwOyZu
YnNwOyBzbGF2ZSB7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgcGNt
IHs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsm
bmJzcDsgQGZ1bmMgY29uY2F0PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJz
cDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cmluZ3MgWzxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5i
c3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgImNh
cmRzLnBjbS5waG9uZWxpbmU6Q0FSRD0iICRDQVJEICIsREVWPSIgJERFVjxicj4mbmJzcDsmbmJz
cDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBdPGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4mbmJzcDsmbmJzcDsmbmJzcDsg
fTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgaG9va3MuMCB7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgdHlwZSBjdGxfZWxlbXM8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZu
YnNwOyZuYnNwOyZuYnNwOyBob29rX2FyZ3MgWzxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7
Jm5ic3A7Jm5ic3A7IHs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgbmFtZSAiT2ZmLWhvb2sgU3dpdGNoIjxicj4mbmJzcDsmbmJzcDsm
bmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBwcmVzZXJ2ZSB0cnVl
PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5i
c3A7IHZhbHVlICJvbiI8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgbG9jayBmYWxzZTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7
Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyBvcHRpb25hbCB0cnVlPGJyPiZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5i
c3A7Jm5ic3A7Jm5ic3A7IF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGhpbnQuc2hvdyBvZmY8YnI+fTxicj48YnI+Izxicj4jU2FtcGxlIGZvciB1c2luZyBw
aG9uZSBzaW11bGF0b3I8YnI+Izxicj5bcGhvbmVzaW1dPGJyPkRyaXZlcj1waG9uZXNpbTxicj5B
ZGRyZXNzPTEyNy4wLjAuMTxicj5wb3J0PTEyMzQ1PGJyPjxicj4tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPjxicj5UaGFu
a3MgYW5kIFJlZ2FyZHMsPGJyPktyaXNobmEgSyBLYW5kdWxhPGJyPiAJCSAJICAgCQkgIDxiciAv
PjxociAvPkNhdGNoIHRoZSBjaGFuZ2luZyBzZWN1cml0eSBlbnZpcm9ubWVudCA8YSBocmVmPSdo
dHRwOi8vbmV3cy5pbi5tc24uY29tL2ludGVybmFsc2VjdXJpdHkvJyB0YXJnZXQ9J19uZXcnPkdl
dCBpdCBub3cuPC9hPjwvYm9keT4KPC9odG1sPg==
--===============6716159873049186514==--

