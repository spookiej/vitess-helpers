import pytest
import json
from vitess_helpers import shard_ranges

TEST_RANGES = [1,2,10,100,256,257,1000,12000,65536]

@pytest.mark.parametrize("num_shards", TEST_RANGES)
def test_number_shards(num_shards):
    gen_range = shard_ranges(num_shards)
    assert len(gen_range) == num_shards
    with open("tests/files/" + str(num_shards) + "_shard.json") as file:
        expected = json.load(file)
    assert gen_range == expected

def test_out_of_range():
    with pytest.raises(ValueError) as error:
        gen_range = shard_ranges(2**(8*2)+1)

    assert str(error.value) == "number of shards must be less than 65536"

def test_zero_shards():
    with pytest.raises(ValueError) as error:
        gen_range = shard_ranges(0)

    assert str(error.value) == "number of shards must be greater than zero"
