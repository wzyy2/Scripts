from eth_keys import keys
from eth_utils import decode_hex

import asyncio
from bscscan import BscScan

YOUR_API_KEY = "-"


async def ask_bscscan(public_key):
  async with BscScan(YOUR_API_KEY) as bsc:
   bnb_num = float(await bsc.get_bnb_balance(address=public_key))
   if (bnb_num) != 0:
       print(public_key)


def get_bnb(p_k):
    priv_key_bytes = decode_hex(p_k)
    priv_key = keys.PrivateKey(priv_key_bytes)
    pub_key = priv_key.public_key
    pub_key = pub_key.to_checksum_address()
    asyncio.run(ask_bscscan(pub_key))
    # print(pub_key)


key_str = '0x74e6d927d9ed225d9f5847fb6f315ca975cdafce4692d19cc586790506b76ee'
for i in range(2, len(key_str)):
    for j in range(ord('a'), ord('f')+1):
        key_str2 = key_str[:i] + chr(j) + key_str[i:]
        get_bnb(key_str2)

    for j in range(0, 10):
        key_str2 = key_str[:i] + str(j) + key_str[i:]
        get_bnb(key_str2)

