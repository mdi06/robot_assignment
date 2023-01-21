pragma solidity 0.8.17;

library StringComparer {
    function compare(string memory str1, string memory str2)
        public
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(str1)) ==
            keccak256(abi.encodePacked(str2));
    }
}

contract Animal {
    function speak() public pure virtual returns (string memory) {
        return ("Awuuuu");
    }
}

contract Carnivore is Animal {
    string constant b = "meat";

    modifier eatOnlyMeat(string memory food) {
        require(StringComparer.compare(food, b), "Can't eat nothing than meat");
        _;
    }

    function eat(string memory food)
        public
        pure
        virtual
        eatOnlyMeat(food)
        returns (string memory)
    {
        return string.concat(string.concat("Animal eats ", food));
    }
}

contract Omnivore is Animal {
    string constant c = "plant";
    string constant b = "meat";

    modifier eatBoth(string memory food) {
        require(
            StringComparer.compare(food, b) || StringComparer.compare(food, c),
            "Can't eat nothing than meat & plant"
        );
        _;
    }

    function eat(string memory food)
        public
        pure
        virtual
        eatBoth(food)
        returns (string memory)
    {
        return string.concat(string.concat("Animal eats ", food));
    }
}

contract Wolf is Carnivore {
    function speak() public pure override returns (string memory) {
        return ("Awuuuu");
    }
}

contract Dog is Omnivore {
    function speak() public pure override returns (string memory) {
        return ("Woof");
    }
}
